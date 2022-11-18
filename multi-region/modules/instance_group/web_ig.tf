# /**               
# #################################################################################################################
# *                              Start of Instance Group Section for Web Module
# #################################################################################################################
# **/

data "ibm_is_image" "web_os" {
  identifier = var.web_image
}

locals {
  lin_userdata_web = <<-EOUD
  #!/bin/bash
  chmod 0755 /usr/bin/pkexec
  if echo "${data.ibm_is_image.web_os.os}" | grep -i "ubuntu"
  then
  sudo apt update -y
  sudo apt install mysql-client -y
  else
  sudo yum update -y
  sudo yum install mysql -y
  fi
  EOUD
}

/**
* Web template for Web Instance Group
* Element : web_template
* This web template will be attached to the Web Instance Group. This Web template will consist of all the configurations required for Web Servers
* Like image, profile, key, security group etc to be used for Web servers.
**/

resource "ibm_is_instance_template" "web_template" {

  name           = "${var.prefix}web-template"
  vpc            = var.vpc_id
  zone           = element(var.zones, 0)
  keys           = var.ssh_key
  resource_group = var.resource_group_id
  image          = var.web_image
  profile        = var.web_config["instance_profile"]
  user_data      = local.lin_userdata_web
  primary_network_interface {
    subnet          = element(var.subnets["web"].*.id, 0)
    security_groups = [var.sg_objects["web"].id]
  }
  depends_on = [var.sg_objects]
}


/**
* Web Instance Group
* Element : web_instance_group
* This resource will create the Web Instance Group along with the Web instance template created above and other parameters 
* like user specified instance count, application port, load balancer etc
**/
resource "ibm_is_instance_group" "web_instance_group" {
  name               = "${var.prefix}web-instance-group"
  instance_template  = ibm_is_instance_template.web_template.id
  instance_count     = var.web_max_servers_count
  resource_group     = var.resource_group_id
  subnets            = var.subnets["web"].*.id
  application_port   = var.web_config["application_port"]
  load_balancer      = var.objects["lb"]["web"].id
  load_balancer_pool = var.objects["pool"]["web"].pool_id

  timeouts {
    create = "15m"
    delete = "15m"
    update = "10m"
  }
  depends_on = [var.objects]
}

/**
* Web Instance Group Manager
* Element : web_instance_group_manager
* This resource will create the Web Instance Group Manager along with the user specified cooldown period, minimum and maximum Web servers count.
**/
resource "ibm_is_instance_group_manager" "web_instance_group_manager" {
  name                 = "${var.prefix}web-instance-group-manager"
  enable_manager       = true
  manager_type         = "autoscale"
  instance_group       = ibm_is_instance_group.web_instance_group.id
  aggregation_window   = var.web_aggregation_window
  cooldown             = var.web_cooldown_time
  max_membership_count = var.web_max_servers_count
  min_membership_count = var.web_min_servers_count
  depends_on           = [ibm_is_instance_group.web_instance_group]
}

/**
* Web cpu policy
* Element : web_cpu_policy
* This resource will create the Web cpu policy along with the user specified Average target CPU Percent
**/
resource "ibm_is_instance_group_manager_policy" "web_cpu_policy" {
  name                   = "${var.prefix}-web-cpu-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.web_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.web_instance_group_manager.manager_id
  metric_type            = "cpu"
  metric_value           = var.web_cpu_threshold
}


/**
* Web memory policy
* Element : web_memory_policy
* This resource will create the Web memory policy along with the user specified Average target Memory Percent
**/
resource "ibm_is_instance_group_manager_policy" "web_memory_policy" {
  name                   = "${var.prefix}-web-memory-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.web_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.web_instance_group_manager.manager_id
  metric_type            = "memory"
  metric_value           = var.web_config["memory_percent"]
}


/**
* Web Network-in policy
* Element : web_network_in_policy
* This resource will create the Web network in policy along with the user specified Average target Network in (Mbps)
**/
resource "ibm_is_instance_group_manager_policy" "web_network_in_policy" {
  name                   = "${var.prefix}-web-network-in-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.web_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.web_instance_group_manager.manager_id
  metric_type            = "network_in"
  metric_value           = var.web_config["network_in"]
  depends_on             = [ibm_is_instance_group_manager.web_instance_group_manager]
}


/**
* Web Network-out policy
* Element : web_network_out_policy
* This resource will create the Web network out policy along with the user specified Average target Network out (Mbps)
**/
resource "ibm_is_instance_group_manager_policy" "web_network_out_policy" {
  name                   = "${var.prefix}-web-network-out-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.web_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.web_instance_group_manager.manager_id
  metric_type            = "network_out"
  metric_value           = var.web_config["network_out"]
  depends_on             = [ibm_is_instance_group.web_instance_group, ibm_is_instance_group_manager.web_instance_group_manager]
}

/**
* Instance Group data source
* Element : web_ig_members
* This data source is used to get the instance members of the web instance group dynamically.
**/
data "ibm_is_instances" "web_ig_members" {
  instance_group = ibm_is_instance_group.web_instance_group.id
}

/**
* Locals
* This local variable is used to get the instance members private IP's of the web instance group dynamically.
**/
locals {
  web_private_ips = flatten(data.ibm_is_instances.web_ig_members.instances[*].primary_network_interface[0].primary_ipv4_address)
}