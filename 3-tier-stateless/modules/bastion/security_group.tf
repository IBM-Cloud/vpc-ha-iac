/**
#################################################################################################################
*                  Resources Section of the Security Group Module for Bastion Tier
#################################################################################################################
*/

/**
* This local variables checks the bastion os type and open ports accordingly.
*/
locals {
  sg_port = lower(var.bastion_os_type) == "windows" ? "3389" : "22"
}

/**
* Security Group for Bastion Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* Bastion Server
**/

resource "ibm_is_security_group" "bastion" {
  name           = "${var.prefix}bastion-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

# /**
# *
# #                             Security Group Rules for the Bastion Server
# *
# */

/**
* Security Group Rule for Bastion Server
* This inbound rule will allow the user to ssh connect to the Bastion server on port 22 from their local machine.
* This rule will only whitelist/allow the user's public IP address. So that no other person can access the bastion server.
**/

resource "ibm_is_security_group_rule" "bastion_rule_22" {
  group     = ibm_is_security_group.bastion.id
  count     = length(var.public_ip_address_list)
  direction = "inbound"
  remote    = var.public_ip_address_list[count.index]
  tcp {
    port_min = local.sg_port
    port_max = local.sg_port
  }
}

/**
* Security Group Rule for Bastion Server
* This will allow all the outbound traffic from the Bastion server. Inbound traffics are restricted though, as specified in above rule.
**/

resource "ibm_is_security_group_rule" "bastion_outbound" {
  group     = ibm_is_security_group.bastion.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}
