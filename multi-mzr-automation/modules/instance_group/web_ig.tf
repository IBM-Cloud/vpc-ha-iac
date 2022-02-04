/**
#################################################################################################################
*                                Instance group section for Web Module
*                                 Start Here for the Resources Section 
#################################################################################################################
*/

data "ibm_is_image" "web_os" {
  identifier = var.web_image
}

locals {
  lin_userdata_web_ubuntu = <<-EOUD
  #!/bin/bash 
  db_name=${var.db_name}
  db_user=${var.db_user}
  db_pwd=${var.db_pwd} 
  sudo apt-get -y update
  sudo apt-get install -y php php-dev libapache2-mod-php php-curl apache2
  sudo apt-get install -y php-json php-gd php-mysql mariadb-client
  rm /var/www/html/index.html
  systemctl start apache2 && systemctl enable apache2
  sed -i '0,/AllowOverride\ None/! {0,/AllowOverride\ None/ s/AllowOverride\ None/AllowOverride\ All/}' /etc/apache2/apache2.conf
  install_dir="/var/www/html"
  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod 755 wp-cli.phar
  sudo mv wp-cli.phar /usr/local/bin/wp
  chmod -R 775 /var/www/
  chown www-data: $install_dir -R
  sudo -u www-data /usr/local/bin/wp core download --path=$install_dir
  sudo -u www-data /usr/local/bin/wp config create --dbname='${var.db_name}' --skip-salts --dbuser='${var.db_user}' --dbpass='${var.db_pwd}' --dbhost='${var.db_private_ip}' --dbprefix='wp_' --path=$install_dir
  sudo -u www-data /usr/local/bin/wp core install --url='${var.web_lb_hostname}' --title='${var.wp_blog_title}' --admin_user='${var.wp_admin_user}' --admin_password='${var.wp_admin_password}' --admin_email='${var.wp_admin_email}' --path=$install_dir
  rm /var/www/html/index.html
  yum remove mariadb-client -y
  systemctl restart apache2
  chmod 0755 /usr/bin/pkexec   
  EOUD

  lin_userdata_web_rhel = <<-EOUD
  #!/bin/bash 
  db_name=${var.db_name}
  db_user=${var.db_user}
  db_pwd=${var.db_pwd} 
  yum update -y 
  install_dir="/var/www/html"

  if cat /etc/redhat-release |grep -i "release 8"
  then
    yum install -y httpd php git 
    yum install -y php-devel
    yum install -y php-pear php-json php-gd php-mysqlnd mariadb
    yum install -y wget 
    systemctl start httpd && systemctl enable httpd 
    chown -R apache $install_dir -R
    chmod -R 775 /var/www/
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod 755 wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
    sudo -u apache /usr/local/bin/wp core download --path=$install_dir
    sudo -u apache /usr/local/bin/wp config create --dbname='${var.db_name}' --skip-salts --dbuser='${var.db_user}' --dbpass='${var.db_pwd}' --dbhost='${var.db_private_ip}' --dbprefix='wp_' --path=$install_dir
    sudo -u apache /usr/local/bin/wp core install --url='${var.web_lb_hostname}' --title='${var.wp_blog_title}' --admin_user='${var.wp_admin_user}' --admin_password='${var.wp_admin_password}' --admin_email='${var.wp_admin_email}' --path=$install_dir
    systemctl start httpd && systemctl enable httpd
    yum remove mariadb -y
  fi 

  if cat /etc/redhat-release |grep -i "release 7"
  then
    yum install -y httpd git
    yum install -y wget
    rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
    sudo yum-config-manager --enable remi-php72
    sudo yum -y update 
    sudo yum -y install php php-devel php-pear php-json php-gd php-mysql mariadb
    chown -R apache $install_dir -R
    chmod -R 775 /var/www/
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod 755 wp-cli.phar
    sudo mv wp-cli.phar /usr/local/bin/wp
    sudo -u apache /usr/local/bin/wp core download --path=$install_dir
    sudo -u apache /usr/local/bin/wp config create --dbname='${var.db_name}' --skip-salts --dbuser='${var.db_user}' --dbpass='${var.db_pwd}' --dbhost='${var.db_private_ip}' --dbprefix='wp_' --path=$install_dir
    sudo -u apache /usr/local/bin/wp core install --url='${var.web_lb_hostname}' --title='${var.wp_blog_title}' --admin_user='${var.wp_admin_user}' --admin_password='${var.wp_admin_password}' --admin_email='${var.wp_admin_email}' --path=$install_dir
    systemctl start httpd && systemctl enable httpd
    yum remove mariadb -y
    setenforce Permissive
    firewall-cmd --permanent --zone=public --add-port=3306/tcp
    firewall-cmd --reload
    firewall-cmd --permanent --zone=public --add-port=80/tcp
    firewall-cmd --reload
    setenforce Enforcing
    sudo setsebool -P httpd_can_network_connect 1
  fi
  systemctl restart httpd
  chmod 0755 /usr/bin/pkexec
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
  user_data      = split("-", data.ibm_is_image.web_os.os)[0] == "ubuntu" ? local.lin_userdata_web_ubuntu : local.lin_userdata_web_rhel
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