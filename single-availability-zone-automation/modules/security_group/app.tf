/**
#################################################################################################################
*                      Resources Section of the Security Group Module for App Tier
#################################################################################################################
*/

locals {
  sg_port = lower(var.app_os_type) == "windows" ? "3389" : "22"
}

/**
* Security Group for App Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* App Server
**/

resource "ibm_is_security_group" "app" {
  name           = "${var.prefix}app-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}

/**
*
#                             Security Group Rules for the App Server
*
*/

/**
* Security Group Rule for App Server
* This inbound rule will allow the Bastion server to ssh connect to the App server on port 22.
**/

resource "ibm_is_security_group_rule" "app_rule_22" {
  group     = ibm_is_security_group.app.id
  direction = "inbound"
  remote    = var.bastion_sg
  tcp {
    port_min = local.sg_port
    port_max = local.sg_port
  }
}

/**
* Security Group Rule for App Server
* This inbound rule will allow the Load Balancer to access the App servers on the Application load balancer listener port
**/

resource "ibm_is_security_group_rule" "app_rule_lb_listener" {
  group     = ibm_is_security_group.app.id
  direction = "inbound"
  remote    = ibm_is_security_group.lb_sg.id

  tcp {
    port_min = var.alb_port
    port_max = var.alb_port
  }
}

/**
* Security Group Rule for App Server
* This is the temporary rule added to check the telnet connection from web to app server.
* We need to modify the port later with the required port number
**/

resource "ibm_is_security_group_rule" "app_rule_80" {
  group     = ibm_is_security_group.app.id
  direction = "inbound"
  remote    = ibm_is_security_group.web.id
  tcp {
    port_min = "80"
    port_max = "80"
  }
}

/**
* Security Group Rule for App Server
* This will allow all the outbound traffic from the App servers. Inbound traffics are restricted though, as specified in above rules.
**/

resource "ibm_is_security_group_rule" "app_outbound" {
  group     = ibm_is_security_group.app.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}
