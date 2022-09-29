/**
#################################################################################################################
*                  Resources Section of the Security Group Module for DB Tier
#################################################################################################################
*/

/**
* This local variables checks the db os type and open ports accordingly.
*/
locals {
  db_sg_port = "22"
}

/**
* Security Group for DB Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* DB Server
**/

resource "ibm_is_security_group" "db" {
  name           = "${var.prefix}db-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group_id
}
# /**
# *
# #                             Security Group Rules for the DB Server
# *
# */

/**
* Security Group Rule for DB Server
* This inbound rule will allow the Bastion server to ssh connect to the DB server on port 22.
**/

resource "ibm_is_security_group_rule" "db_rule_22" {
  group     = ibm_is_security_group.db.id
  direction = "inbound"
  remote    = var.bastion_sg
  tcp {
    port_min = local.db_sg_port
    port_max = local.db_sg_port
  }
}

/**
* Security Group for DB Server
* This is the temporary rule added to check the telnet connection from App to DB server.
* We need to modify the port later with the required port
**/

resource "ibm_is_security_group_rule" "db_rule_80" {
  group     = ibm_is_security_group.db.id
  direction = "inbound"
  remote    = ibm_is_security_group.app.id
  tcp {
    port_min = "80"
    port_max = "80"
  }
}

/**
* Security Group Rule for DB Server
* This will allow all the outbound traffic from the DB servers. Inbound traffics are restricted though, as specified in above rules.
**/

resource "ibm_is_security_group_rule" "db_outbound" {
  group     = ibm_is_security_group.db.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}
