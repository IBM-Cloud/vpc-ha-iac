/**
#################################################################################################################
*                           Virtual Server Instance Section for the Instance Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Virtual Server Instance for Bastion Server or Jump Server
* Element : VSI
* This resource will be used to create a Bastion Server.
**/
resource "ibm_is_instance" "bastion" {
  name           = "${var.prefix}bastion-vsi"
  keys           = var.ssh_key
  image          = var.bastion_image
  profile        = var.bastion_profile
  resource_group = var.resource_group
  vpc            = var.vpc_id
  zone           = var.zones[0]
  depends_on     = [var.bastion_sg]

  primary_network_interface {
    subnet          = var.bastion_subnet
    security_groups = [var.bastion_sg]
  }
}

/**
* Floating IP address for Bastion Server or Jump Server
* Element : VSI
* This resource will be used to attach a floating IP address.
**/
resource "ibm_is_floating_ip" "bastion_floating_ip" {
  name           = "${var.prefix}bastion-fip"
  resource_group = var.resource_group
  target         = ibm_is_instance.bastion.primary_network_interface.0.id
  depends_on     = [ibm_is_instance.bastion]
}

/**
* Output Variable
* Element : Bastion IP
* Floating IP address for the Bastion VSI
* This variable will return array of IP address for the Web VSI
**/
output "bastion_ip" {
  value       = ibm_is_floating_ip.bastion_floating_ip.address
  description = "Bastion Server Floating IP Address"
  depends_on  = [ibm_is_instance.bastion, ibm_is_floating_ip.bastion_floating_ip]
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
  resource_group = var.resource_group
  vpc            = var.vpc_id
  zone           = var.zones[count.index % length(var.zones)]
  user_data      = <<-EOUD
            #!/bin/bash
            sed -i 's/nginx!/nginx! ${var.zones[count.index % length(var.zones)]}-Web Server-${count.index + 1}/' /var/www/html/index.nginx-debian.html
            EOUD

  depends_on = [var.web_sg]

  primary_network_interface {
    subnet          = var.web_subnet[count.index % length(var.zones)]
    security_groups = [var.web_sg]
  }
}

/**
* Output Variable
* Element : Web Target
* Primary IP address for the web VSI
* This variable will return array of IP address for the Web VSI
**/
output "web_target" {
  value       = ibm_is_instance.web.*.primary_network_interface.0.primary_ipv4_address
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.web]
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
  resource_group = var.resource_group
  vpc            = var.vpc_id
  zone           = var.zones[count.index % length(var.zones)]
  depends_on     = [var.app_sg]

  primary_network_interface {
    subnet          = var.app_subnet[count.index % length(var.zones)]
    security_groups = [var.app_sg]
  }
}

/**
* Output Variable
* Element : App Target
* Primary IP address for the db VSI
* This variable will return array of IP address for the DB VSI
**/
output "app_target" {
  value       = ibm_is_instance.app.*.primary_network_interface.0.primary_ipv4_address
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.app]
}



/**
* Virtual Server Instance for DB
* Element : VSI
* This resource will be used to create a DB VSI as per the user input.
**/
resource "ibm_is_instance" "db" {
  count          = length(var.total_instance) * length(var.zones)
  name           = "${var.prefix}db-vsi-${floor(count.index / length(var.zones)) + 1}-${var.zones[count.index % length(var.zones)]}"
  keys           = var.ssh_key
  image          = var.db_image
  profile        = var.db_profile
  resource_group = var.resource_group
  vpc            = var.vpc_id
  zone           = var.zones[count.index % length(var.zones)]
  depends_on     = [var.db_sg]

  primary_network_interface {
    subnet          = var.db_subnet[count.index % length(var.zones)]
    security_groups = [var.db_sg]
  }
}

/**
* Output Variable
* Element : DB Target
* Primary IP address for the web VSI
* This variable will return array of IP address for the DB VSI
**/
output "db_target" {
  value       = ibm_is_instance.db.*.primary_network_interface.0.primary_ipv4_address
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.db]
}

/**
* Output Variable
* Element : Compute instance
* This will return the web vsi reference
**/
output "web_vsi" {
  value       = ibm_is_instance.web
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.web]
}

/**
* Output Variable
* Element : Compute instance
* This will return the app vsi reference
**/
output "app_vsi" {
  value       = ibm_is_instance.app
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.app]
}


/**
* Output Variable
* Element : Compute instance
* This will return the db vsi reference
**/
output "db_vsi" {
  value       = ibm_is_instance.db
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.db]
}
