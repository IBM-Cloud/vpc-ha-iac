/**
#################################################################################################################
*                           Virtual Server Instance Section for the Instance Module.
*                                 Start Here of the compute Section 
#################################################################################################################
*/

data "ibm_is_image" "web_os" {
  identifier = var.web_image
}
data "ibm_is_image" "app_os" {
  identifier = var.app_image
}

data "ibm_is_image" "db_os" {
  identifier = var.db_image
}

locals {
  lin_userdata_db_ubuntu = <<-EOUD
      #!/bin/bash
      db_name=${var.db_name}
      db_admin_user=admin
      db_password=${var.db_password}      
      sudo apt update -y
      sudo apt install -y mariadb-server mariadb-client
      sudo systemctl enable mariadb
      sudo systemctl start mariadb   
      mysql -u root -e "SHOW DATABASES;"
      mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
      mysql -u root -e "FLUSH PRIVILEGES;"
      mysql -u root -e "CREATE DATABASE $db_name;"
      mysql -u root -e "CREATE USER '$db_admin_user'@'%' IDENTIFIED BY '$db_password';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_admin_user'@'%';"
      mysql -u root -e "FLUSH PRIVILEGES;"
      sed -i s/'bind-address'/'#bind-address'/g /etc/mysql/mariadb.conf.d/50-server.cnf
      systemctl restart mariadb
      chmod 0755 /usr/bin/pkexec
      EOUD 

  lin_userdata_db_rhel = <<-EOUD
      #!/bin/bash
      db_name=${var.db_name}
      db_admin_user=admin
      db_password=${var.db_password}
      yum update -y 
      sudo yum install -y mariadb-server
      systemctl start mariadb
      systemctl enable mariadb
      mysql -u root -e "SHOW DATABASES;"
      mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'password';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
      mysql -u root -e "FLUSH PRIVILEGES;"
      /usr/bin/mysql -u root -e "CREATE DATABASE $db_name;"
      mysql -u root -e "CREATE USER '$db_admin_user'@'%' IDENTIFIED BY '$db_password';"
      mysql -u root -e "GRANT ALL PRIVILEGES ON $db_name.* TO '$db_admin_user'@'%';"
      mysql -u root -e "FLUSH PRIVILEGES;"
      if cat /etc/redhat-release |grep -i "release 7"
      then
      setenforce Permissive
      firewall-cmd --permanent --zone=public --add-port=3306/tcp
      firewall-cmd --reload
      setenforce Enforcing
      fi
      systemctl restart mariadb
      chmod 0755 /usr/bin/pkexec
      EOUD
}

locals {
  web_lin_userdata = <<-EOUD
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

  app_lin_userdata = <<-EOUD
  #!/bin/bash
  chmod 0755 /usr/bin/pkexec
  if echo "${data.ibm_is_image.app_os.os}" | grep -i "ubuntu"
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
* Virtual Server Instance for Web
* Element : VSI
* This resource will be used to create a Web VSI as per the user input.
**/
resource "ibm_is_instance" "web" {
  count          = length(var.total_instance) * length(var.zones)
  name           = "${var.prefix}web-vsi-${floor(count.index / length(var.zones)) + 1}-${var.zones[count.index % length(var.zones)]}"
  keys           = var.ssh_key
  image          = var.web_image
  profile        = var.web_profile
  resource_group = var.resource_group_id
  vpc            = var.vpc_id
  user_data      = local.web_lin_userdata
  zone           = var.zones[count.index % length(var.zones)]

  depends_on = [var.web_sg]

  primary_network_interface {
    subnet          = var.web_subnet[count.index % length(var.zones)]
    security_groups = [var.web_sg]
  }
}

/**
* Virtual Server Instance for App
* Element : VSI
* This resource will be used to create a App VSI as per the user input.
**/
resource "ibm_is_instance" "app" {
  count          = length(var.total_instance) * length(var.zones)
  name           = "${var.prefix}app-vsi-${floor(count.index / length(var.zones)) + 1}-${var.zones[count.index % length(var.zones)]}"
  keys           = var.ssh_key
  image          = var.app_image
  profile        = var.app_profile
  resource_group = var.resource_group_id
  vpc            = var.vpc_id
  zone           = var.zones[count.index % length(var.zones)]
  depends_on     = [var.app_sg]
  user_data      = local.app_lin_userdata
  primary_network_interface {
    subnet          = var.app_subnet[count.index % length(var.zones)]
    security_groups = [var.app_sg]
  }
}

/**
* Virtual Server Instance for DB
* Element : VSI
* This resource will be used to create a DB VSI as per the user input.
**/
resource "ibm_is_instance" "db" {
  count          = var.enable_dbaas ? 0 : var.db_vsi_count
  name           = "${var.prefix}db-vsi-${floor(count.index / length(var.zones)) + 1}-${var.zones[count.index % length(var.zones)]}"
  keys           = var.ssh_key
  image          = var.db_image
  profile        = var.db_profile
  resource_group = var.resource_group_id
  vpc            = var.vpc_id
  zone           = var.zones[count.index % length(var.zones)]
  depends_on     = [var.db_sg]
  user_data      = split("-", data.ibm_is_image.db_os.os)[0] == "ubuntu" ? local.lin_userdata_db_ubuntu : local.lin_userdata_db_rhel
  primary_network_interface {
    subnet          = var.db_subnet[count.index % length(var.zones)]
    security_groups = [var.db_sg]
  }
}