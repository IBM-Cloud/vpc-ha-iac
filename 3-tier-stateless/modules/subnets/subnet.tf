resource "ibm_is_subnet" "bastion_sub" {
  name                     = "${var.prefix}bastion"
  vpc                      = var.vpc_id
  zone                     = var.zones[0]
  total_ipv4_address_count = var.bastion_ip_count
  resource_group           = var.resource_group
}

output "bastion_subnet_id" {
  value       = ibm_is_subnet.bastion_sub.id
  description = "Subnet id of Bastion"
}

/**
*
* All three subnets Web, App and DB for the Zone 1
*
*/

resource "ibm_is_subnet" "web_subnet" {
  count                    = length(var.zones)
  name                     = "${var.prefix}zone-${count.index + 1}-web"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group
  zone                     = var.zones[count.index]
  total_ipv4_address_count = var.ip_count
}

output "web_subnet_ids" {
  value       = ibm_is_subnet.web_subnet.*.id
  description = "Subnet ids of Web for all zones"
}

resource "ibm_is_subnet" "app_subnet" {
  count                    = length(var.zones)
  name                     = "${var.prefix}zone-${count.index + 1}-app"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group
  zone                     = var.zones[count.index]
  total_ipv4_address_count = var.ip_count
}

output "app_subnet_ids" {
  value       = ibm_is_subnet.app_subnet.*.id
  description = "Subnet ids of App for all zones"
}

resource "ibm_is_subnet" "db_subnet" {
  count                    = length(var.zones)
  name                     = "${var.prefix}zone-${count.index + 1}-db"
  vpc                      = var.vpc_id
  resource_group           = var.resource_group
  zone                     = var.zones[count.index]
  total_ipv4_address_count = var.ip_count
}

output "db_subnet_ids" {
  value       = ibm_is_subnet.db_subnet.*.id
  description = "Subnet ids of DB for all zones"
}
