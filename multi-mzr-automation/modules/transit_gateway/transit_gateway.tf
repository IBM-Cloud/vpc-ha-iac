/**
#################################################################################################################
*                           Resources Section for the Transit Gateway Module.
#################################################################################################################
*/

/**
* Transit Gateway for VPC's
* Element : transit gateway
* This resource will be used to create a transit gateway.
**/
resource "ibm_tg_gateway" "tg_gateway" {
  name           = "${var.prefix}tg"
  global         = true
  location       = var.location
  resource_group = var.resource_group_id
}

/**
* Transit gateway connection for region-1
* Element : transit gateway
* This resource will be used to create a connection from Region-1 to transit gateway
**/

resource "ibm_tg_connection" "tg_gateway_region_1" {
  gateway      = ibm_tg_gateway.tg_gateway.id
  network_type = "vpc"
  name         = "${var.prefix}tg-connection-region-1"
  network_id   = var.vpc_crn_region1
}

/**
* Transit gateway connection for region-2
* Element : transit gateway
* This resource will be used to create a connection from Region-2 to transit gateway
**/

resource "ibm_tg_connection" "tg_gateway_region_2" {
  gateway      = ibm_tg_gateway.tg_gateway.id
  network_type = "vpc"
  name         = "${var.prefix}tg-connection-region-2"
  network_id   = var.vpc_crn_region2
}