/**
#################################################################################################################
*                              Resources Section for the VPN Module
#################################################################################################################
*/

/**
* VPN Gateway at the VPC side
* Element : VPN Gateway
* This resource will be used to create a VPN Gateway.
**/
resource "ibm_is_vpn_gateway" "vpn_gateway" {
  name           = "${var.prefix}vpn"
  subnet         = var.subnet
  mode           = var.vpn_mode
  resource_group = var.resource_group_id
  tags           = var.tags
}

/**
* VPN gateway Connection 
* Element : VPN Gateway Connection
* This resource will be used to create a VPN Gateway Connection.
**/
resource "ibm_is_vpn_gateway_connection" "VPNGatewayConnection" {
  name           = "${var.prefix}vpn-connection"
  vpn_gateway    = ibm_is_vpn_gateway.vpn_gateway.id
  peer_address   = var.peer_gateway_ip
  preshared_key  = var.preshared_key
  local_cidrs    = var.local_cidrs
  peer_cidrs     = var.peer_cidrs
  action         = var.action
  admin_state_up = var.admin_state_up
  interval       = var.interval
  timeout        = var.timeout
  ike_policy     = ibm_is_ike_policy.ike_policy.id
  ipsec_policy   = ibm_is_ipsec_policy.ipsec_policy.id
}

/**
* IKE Policy for VPN gateway Connection 
* Element : IKE Policy
* This resource will be used to create the IKE Policy for VPN gateway Connection.
* IKE is an IPSec (Internet Protocol Security) standard protocol that is used to ensure secure communication over the VPC VPN service.
**/
resource "ibm_is_ike_policy" "ike_policy" {
  name                     = "${var.prefix}ike-policy"
  resource_group           = var.resource_group_id
  authentication_algorithm = var.authentication_algorithm
  encryption_algorithm     = var.encryption_algorithm
  dh_group                 = var.dh_group
  ike_version              = var.ike_version
  key_lifetime             = var.key_lifetime["ike"]
}

/**
* IPsec Policy for VPN gateway Connection 
* Element : IPsec Policy
* This resource will be used to create the IPsec Policy for VPN gateway Connection.
**/
resource "ibm_is_ipsec_policy" "ipsec_policy" {
  name                     = "${var.prefix}ipsec-policy"
  authentication_algorithm = var.authentication_algorithm
  encryption_algorithm     = var.encryption_algorithm
  resource_group           = var.resource_group_id
  pfs                      = var.perfect_forward_secrecy
  key_lifetime             = var.key_lifetime["ipsec"]
}

/**
* Routing table for VPN gateway connection 
* Element : Routing Table
* This resource will be used to create the Routing table for VPN gateway connection.
**/
resource "ibm_is_vpc_routing_table" "vpn_routing_table" {
  count                         = var.vpn_mode == "route" ? 1 : 0
  vpc                           = var.vpc_id
  name                          = "${var.prefix}route-table"
  route_direct_link_ingress     = false
  route_transit_gateway_ingress = false
  route_vpc_zone_ingress        = false
}

/**
* Routing Table route for VPN Gateway connection
* Element : Routing Table route
* This resource will be used to create the Routing Table route for VPN Gateway connection.
* It will have the destination to be the user provided peer CIDRs
**/
resource "ibm_is_vpc_routing_table_route" "routing_table_route" {
  count         = var.vpn_mode == "route" ? length(var.peer_cidrs) : 0
  vpc           = var.vpc_id
  routing_table = ibm_is_vpc_routing_table.vpn_routing_table[0].routing_table
  zone          = var.zones[0]
  name          = "${var.prefix}route-${count.index + 1}"
  destination   = var.peer_cidrs[count.index]
  action        = "deliver"
  next_hop      = ibm_is_vpn_gateway_connection.VPNGatewayConnection.gateway_connection
}