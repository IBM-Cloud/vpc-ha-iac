/**
#################################################################################################################
*                           Resources Section for the Public Gateways Module.
#################################################################################################################
*/

/**
* Public Gateway for all subnets in all availability zones
* Element : pg
* This resource will be used to create the Public gateway in all availability zones
**/

resource "ibm_is_public_gateway" "pg" {
  count          = length(var.zones)
  name           = "${var.prefix}pg-${count.index + 1}"
  vpc            = var.vpc_id
  zone           = var.zones[count.index]
  resource_group = var.resource_group_id
}
