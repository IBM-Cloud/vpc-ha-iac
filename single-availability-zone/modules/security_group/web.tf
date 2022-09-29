/**
#################################################################################################################
*                   Resources Section of the Security Group Module for Web Tier
#################################################################################################################
*/

locals {
  web_sg_port = "22"
}

/**
* Security Group for Web Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* Web Server
**/

resource "ibm_is_security_group" "web" {
  name           = "${var.prefix}web-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

# /**
# *
# #                             Security Group Rules for the Web Server
# *
# */

/**
* Security Group Rule for Web Server
* This inbound rule will allow the Bastion server to ssh connect to the Web server on port 22.
**/

resource "ibm_is_security_group_rule" "web_rule_22" {
  group     = ibm_is_security_group.web.id
  direction = "inbound"
  remote    = var.bastion_sg
  tcp {
    port_min = local.web_sg_port
    port_max = local.web_sg_port  
}
}

/**
* Security Group Rule for Web Server
* This inbound rule will allow the Load Balancer to access the Web servers on the 80 port. We can change this port as per the requirement.
**/

resource "ibm_is_security_group_rule" "web_rule_80" {
  group     = ibm_is_security_group.web.id
  direction = "inbound"
  remote    = ibm_is_security_group.lb_sg.id

  tcp {
    port_min = "80"
    port_max = "80"
  }
}

/**
* Security Group Rule for Web Server
* This inbound rule will allow the Load Balancer to access the Web servers on the 443 port. We can change this port as per the requirement.
**/

resource "ibm_is_security_group_rule" "web_rule_443" {
  group     = ibm_is_security_group.web.id
  direction = "inbound"
  remote    = ibm_is_security_group.lb_sg.id
  tcp {
    port_min = "443"
    port_max = "443"
  }
}

/**
* Security Group Rule for Web Server
* This will allow all the outbound traffic from the Web servers. Inbound traffics are restricted though, as specified in above rules.
**/

resource "ibm_is_security_group_rule" "web_outbound" {
  group     = ibm_is_security_group.web.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}
