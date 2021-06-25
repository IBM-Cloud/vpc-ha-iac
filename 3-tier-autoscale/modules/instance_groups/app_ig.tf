# /**               
# #################################################################################################################
# *                              Start  of Instance Group Section for App Module
# #################################################################################################################
# **/

/**
* App template for App Instance Group
* Element : app_template
* This app template will be attached to the App Instance Group. This App template will consist of all the configurations required for App Servers
* Like image, profile, key, security group etc to be used for App servers.
**/
resource "ibm_is_instance_template" "app_template" {

  name           = "${var.prefix}app-template"
  vpc            = var.vpc_id
  zone           = element(var.zones, 0)
  keys           = var.ssh_key
  resource_group = var.resource_group_id
  image          = var.app_config["instance_image"]
  profile        = var.app_config["instance_profile"]

  user_data = <<-EOUD
    #!/bin/bash
    ip_add=`hostname -I`
    sed -i "s/nginx/nginx Web Server-IP: $ip_add/" /var/www/html/index.nginx-debian.html
    EOUD


  primary_network_interface {
    subnet          = element(var.subnets["app"].*.id, 0)
    security_groups = [var.sg_objects["app"].id]
  }
  depends_on = [var.sg_objects]
}

/**
* App Instance Group
* Element : app_instance_group
* This resource will create the App Instance Group along with the App instance template created above and other parameters 
* like user specified instance count, application port, load balancer etc
**/
resource "ibm_is_instance_group" "app_instance_group" {
  name               = "${var.prefix}app-instance-group"
  instance_template  = ibm_is_instance_template.app_template.id
  instance_count     = var.app_max_servers_count
  resource_group     = var.resource_group_id
  subnets            = var.subnets["app"].*.id
  application_port   = var.app_config["application_port"]
  load_balancer      = var.objects["lb"]["app"].id
  load_balancer_pool = var.objects["pool"]["app"].pool_id

  timeouts {
    create = "15m"
    delete = "15m"
    update = "10m"
  }
  depends_on = [var.objects]
}

/**
* App Instance Group Manager
* Element : app_instance_group_manager
* This resource will create the App Instance Group Manager along with the user specified cooldown period, minimum and maximum App servers count.
**/
resource "ibm_is_instance_group_manager" "app_instance_group_manager" {
  name                 = "${var.prefix}app-instance-group-manager"
  enable_manager       = true
  manager_type         = "autoscale"
  instance_group       = ibm_is_instance_group.app_instance_group.id
  aggregation_window   = var.app_aggregation_window
  cooldown             = var.app_cool_down
  max_membership_count = var.app_max_servers_count
  min_membership_count = var.app_min_servers_count

  depends_on = [ibm_is_instance_group.app_instance_group]
}

/**
* App cpu policy
* Element : app_cpu_policy
* This resource will create the App cpu policy along with the user specified Average target CPU Percent
**/
resource "ibm_is_instance_group_manager_policy" "app_cpu_policy" {
  name                   = "${var.prefix}-app-cpu-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.app_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.app_instance_group_manager.manager_id
  metric_type            = "cpu"
  metric_value           = var.app_cpu_percent
}

/**
* App memory policy
* Element : app_memory_policy
* This resource will create the App memory policy along with the user specified Average target Memory Percent
**/
resource "ibm_is_instance_group_manager_policy" "app_memory_policy" {
  name                   = "${var.prefix}-app-memory-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.app_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.app_instance_group_manager.manager_id
  metric_type            = "memory"
  metric_value           = var.app_config["memory_percent"]
}

/**
* App Network-in policy
* Element : app_network_in_policy
* This resource will create the App network in policy along with the user specified Average target Network in (Mbps)
**/
resource "ibm_is_instance_group_manager_policy" "app_network_in_policy" {
  name                   = "${var.prefix}-app-network-in-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.app_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.app_instance_group_manager.manager_id
  metric_type            = "network_in"
  metric_value           = var.app_config["network_in"]
  depends_on             = [ibm_is_instance_group_manager.app_instance_group_manager]
}

/**
* App Network-out policy
* Element : app_network_out_policy
* This resource will create the App network out policy along with the user specified average target Network Out (Mbps)
**/
resource "ibm_is_instance_group_manager_policy" "app_network_out_policy" {
  name                   = "${var.prefix}-app-network-out-policy"
  policy_type            = "target"
  instance_group         = ibm_is_instance_group.app_instance_group.id
  instance_group_manager = ibm_is_instance_group_manager.app_instance_group_manager.manager_id
  metric_type            = "network_out"
  metric_value           = var.app_config["network_out"]
  depends_on             = [ibm_is_instance_group.app_instance_group, ibm_is_instance_group_manager.app_instance_group_manager]
}
