/**
#################################################################################################################
*                   Resources Section of the Security Group Module for LB Tier
#################################################################################################################
*/

/**
* Security Group for Load Balancer
* Defining resource "Security Group". This will be responsible to handle security for the 
* Load Balancer
**/

resource "ibm_is_security_group" "lb_sg" {
  name           = "${var.prefix}lb-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

# /**
# *
# #                             Security Group Rules for the Load Balancer
# *
# */

/**
* Security Group Rule for Load Balancer
* This will allow all the inbound traffic to the Load Balancers.
**/

resource "ibm_is_security_group_rule" "lb_inbound" {
  group      = ibm_is_security_group.lb_sg.id
  direction  = "inbound"
  remote     = "0.0.0.0/0"
  depends_on = [ibm_is_security_group.lb_sg]
}

/**
* Security Group Rule for Load Balancer
* This will allow all the outbound traffic from the Load Balancers.
**/

resource "ibm_is_security_group_rule" "lb_outbound" {
  group      = ibm_is_security_group.lb_sg.id
  direction  = "outbound"
  remote     = "0.0.0.0/0"
  depends_on = [ibm_is_security_group.lb_sg]
}
