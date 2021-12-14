/**
* Subnet for Bastion Server or Jump Server
* Element : subnet
* This resource will be used to create a subnet for Bastion Server.
**/

resource "ibm_is_subnet" "bastion_sub" {
  name                     = "${var.prefix}bastion"
  vpc                      = var.vpc_id
  zone                     = element(var.zones, 0)
  total_ipv4_address_count = var.bastion_ip_count
  resource_group           = var.resource_group_id
}
