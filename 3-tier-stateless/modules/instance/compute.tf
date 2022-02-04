/**
#################################################################################################################
*                           Virtual Server Instance Section for the Instance Module.
*                                 Start Here of the compute Section 
#################################################################################################################
*/

locals {
  lin_userdata = <<-EOUD
  #!/bin/bash
  chmod 0755 /usr/bin/pkexec
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
  user_data      = local.lin_userdata
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
  user_data      = local.lin_userdata
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
  count          = var.db_vsi_count
  name           = "${var.prefix}db-vsi-${floor(count.index / length(var.zones)) + 1}-${var.zones[count.index % length(var.zones)]}"
  keys           = var.ssh_key
  image          = var.db_image
  profile        = var.db_profile
  resource_group = var.resource_group_id
  vpc            = var.vpc_id
  zone           = var.zones[count.index % length(var.zones)]
  depends_on     = [var.db_sg]
  user_data      = local.lin_userdata
  primary_network_interface {
    subnet          = var.db_subnet[count.index % length(var.zones)]
    security_groups = [var.db_sg]
  }
}
