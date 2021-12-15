/**
#################################################################################################################
*                           Resources Section for the Subnets Module.
#################################################################################################################
*/

/**
* Subnet for Web Servers
* Element : web_subnet
* This resource will be used to create a subnet for Web Servers.
**/
resource "ibm_is_subnet" "web_subnet" {
  name                     = "${var.prefix}${var.zone}-web"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group_id
  zone                     = var.zone
  total_ipv4_address_count = var.ip_count["web"]
  public_gateway           = var.public_gateway_id
}

/**
* Subnet for App Servers
* Element : app_subnet
* This resource will be used to create a subnet for App Servers.
**/

resource "ibm_is_subnet" "app_subnet" {
  name                     = "${var.prefix}${var.zone}-app"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group_id
  zone                     = var.zone
  total_ipv4_address_count = var.ip_count["app"]
  public_gateway           = var.public_gateway_id
}

/**
* Subnet for DB Servers
* Element : db_subnet
* This resource will be used to create a subnet for DB Servers.
**/

resource "ibm_is_subnet" "db_subnet" {
  name                     = "${var.prefix}${var.zone}-db"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group_id
  zone                     = var.zone
  total_ipv4_address_count = var.ip_count["db"]
  public_gateway           = var.public_gateway_id
}
