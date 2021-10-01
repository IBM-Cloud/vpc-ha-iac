/**
#################################################################################################################
*                           Resources Section for the Subnets Module.
#################################################################################################################
*/

/**
* Subnet for Web Servers
* Element : subnet
* This resource will be used to create a subnet for Web Servers.
**/

resource "ibm_is_subnet" "web_subnet" {
  count                    = length(var.zones)
  name                     = "${var.prefix}zone-${count.index + 1}-web"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group_id
  zone                     = var.zones[count.index]
  total_ipv4_address_count = var.ip_count["web"]
  public_gateway           = var.public_gateway_ids[count.index]
}

/**
* Subnet for App Servers
* Element : subnet
* This resource will be used to create a subnet for App Servers.
**/

resource "ibm_is_subnet" "app_subnet" {
  count                    = length(var.zones)
  name                     = "${var.prefix}zone-${count.index + 1}-app"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group_id
  zone                     = var.zones[count.index]
  total_ipv4_address_count = var.ip_count["app"]
  public_gateway           = var.public_gateway_ids[count.index]
}

/**
* Subnet for DB Servers
* Element : subnet
* This resource will be used to create a subnet for DB Servers.
**/

resource "ibm_is_subnet" "db_subnet" {
  count                    = length(var.zones)
  name                     = "${var.prefix}zone-${count.index + 1}-db"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group_id
  zone                     = var.zones[count.index]
  total_ipv4_address_count = var.ip_count["db"]
  public_gateway           = var.public_gateway_ids[count.index]
}
