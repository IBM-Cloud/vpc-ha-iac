# /**               
# #################################################################################################################
# *                              Start  of Instance Group Section for App Module
# *                                   Start Here for the Resources Section 
# #################################################################################################################
# **/

data "ibm_is_image" "app_os" {
  identifier = var.app_image
}

locals {
  lin_userdata_app_ubuntu = <<-EOUD
  #!/bin/bash
  sudo apt-get -y update
  sudo apt-get install -y php php-dev libapache2-mod-php php-curl apache2
  sudo apt-get install -y php-json php-gd php-mysql
  systemctl start apache2 && systemctl enable apache2
EOUD

  lin_userdata_app_rhel = <<-EOUD
  #!/bin/bash
  yum update -y
  yum install -y httpd php git
  yum install -y php-devel
  yum install -y php-pear php-json php-gd php-mysqlnd
  yum install -y wget
  systemctl start httpd && systemctl enable httpd
  echo "Welcome to the IBM" > /var/www/html/index.html
  chmod 755 /var/www/html/index.html
  if cat /etc/redhat-release |grep -i "release 7"
  then
  setenforce Permissive
  firewall-cmd --permanent --zone=public --add-port=80/tcp
  firewall-cmd --reload
  setenforce Enforcing
  sudo setsebool -P httpd_can_network_connect 1
  fi      
  systemctl restart httpd
EOUD
}

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
  image          = var.app_image
  user_data      = split("-", data.ibm_is_image.app_os.os)[0] == "ubuntu" ? local.lin_userdata_app_ubuntu : local.lin_userdata_app_rhel
  profile        = var.app_config["instance_profile"]

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
  cooldown             = var.app_cooldown_time
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
  metric_value           = var.app_cpu_threshold
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

/**
* Instance Group data source
* Element : app_ig_members
* This data source is used to get the instance members of the app instance group dynamically.
**/
data "ibm_is_instances" "app_ig_members" {
  instance_group = ibm_is_instance_group.app_instance_group.id
}

/**
* Locals
* This local variable is used to get the instance members private IP's of the app instance group dynamically.
**/
locals {
  app_private_ips = flatten(data.ibm_is_instances.app_ig_members.instances[*].primary_network_interface[0].primary_ipv4_address)
}