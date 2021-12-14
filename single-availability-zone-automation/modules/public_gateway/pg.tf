/**
#################################################################################################################
*                           Resources Section for the Public Gateway Module.
#################################################################################################################
*/

/**
* Public Gateway for all subnets in particular zone 
* Element : pg
* This resource will be used to create the Public gateway in particular zone
**/

resource "ibm_is_public_gateway" "pg" {
  name           = "${var.prefix}${var.zone}-pg"
  vpc            = var.vpc_id
  zone           = var.zone
  resource_group = var.resource_group_id
}
