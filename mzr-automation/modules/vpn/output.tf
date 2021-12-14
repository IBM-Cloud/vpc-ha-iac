/**
#################################################################################################################
*                                 VPN Output Variable Section
#################################################################################################################
**/

/**
* Output Variable
* Element : peer_gateway_ip
* VPN Gateway IP
* This variable will display vpn gateway ip created in the VPC Infrastructure
**/

output "peer_gateway_ip" {
  description = "This variable will display vpn gateway id"
  value       = ibm_is_vpn_gateway.vpn_gateway.public_ip_address
}

/**
* Output Variable
* Element : routing_table_id
* Routing Table ID
* This variable will display the routing table id with vpn route to be associated with the bastion subnet
**/

output "routing_table_id" {
  description = "This variable will display routing table id"
  value       = var.vpn_mode == "route" ? ibm_is_vpc_routing_table.vpn_routing_table[0].routing_table : null
}
