/**
* Security Group for Bastion Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* Bastion Server
**/
resource "ibm_is_security_group" "bastion" {
  name           = "${var.prefix}bastion-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group
}

/**
*
* Output Variable for Bastion Server Security Group
* This variable will return the Bastion Security Group ID 
* 
**/
output "bastion_sg" {
  value       = ibm_is_security_group.bastion.id
  description = "Security Group id for the bastion"
}


/**
* Security Group for Web Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* Web Server
**/
resource "ibm_is_security_group" "web" {
  name           = "${var.prefix}web-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group
}

/**
*
* Output Variable for Web Server Security Group
* This variable will return the Web Security Group ID 
* 
**/
output "web_sg" {
  value       = ibm_is_security_group.web.id
  description = "Security Group id for the web"
}


/**
* Security Group for DB Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* DB Server
**/
resource "ibm_is_security_group" "db" {
  name           = "${var.prefix}db-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group
}

/**
*
* Output Variable for DB Server Security Group
* This variable will return the DB Security Group ID 
* 
**/
output "db_sg" {
  value       = ibm_is_security_group.db.id
  description = "Security Group id for the db"
}


/**
* Security Group for App Server
* Defining resource "Security Group". This will be responsible to handle security for the 
* App Server
**/
resource "ibm_is_security_group" "app" {
  name           = "${var.prefix}app-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group
}

/**
*
* Output Variable for App Server Security Group
* This variable will return the App Security Group ID 
* 
**/
output "app_sg" {
  value       = ibm_is_security_group.app.id
  description = "Security Group id for the app"
}


## sg rules for bastion
resource "ibm_is_security_group_rule" "ssh" {
  group     = ibm_is_security_group.bastion.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

resource "ibm_is_security_group_rule" "ssh_web" {
  group     = ibm_is_security_group.web.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

## sg rules for web
resource "ibm_is_security_group_rule" "ssh-from-bastion" {
  group     = ibm_is_security_group.web.id
  direction = "outbound"
  remote    = ibm_is_security_group.bastion.id
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

resource "ibm_is_security_group_rule" "web_80" {
  group     = ibm_is_security_group.web.id
  direction = "inbound"
  remote    = ibm_is_security_group.lb_sg.id

  tcp {
    port_min = "80"
    port_max = "80"
  }
}

resource "ibm_is_security_group_rule" "web_443" {
  group     = ibm_is_security_group.web.id
  direction = "inbound"
  remote    = ibm_is_security_group.lb_sg.id
  tcp {
    port_min = "443"
    port_max = "443"
  }
}

/**
*
#                             Security Group Rule for the App Server
*
*/

resource "ibm_is_security_group_rule" "ssh_app" {
  group     = ibm_is_security_group.app.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
}

resource "ibm_is_security_group_rule" "app_80" {
  group     = ibm_is_security_group.app.id
  direction = "inbound"
  remote    = ibm_is_security_group.lb_sg.id

  tcp {
    port_min = "80"
    port_max = "80"
  }
}

resource "ibm_is_security_group_rule" "app_443" {
  group     = ibm_is_security_group.app.id
  direction = "inbound"
  remote    = ibm_is_security_group.lb_sg.id
  tcp {
    port_min = "443"
    port_max = "443"
  }
}

/**
*
#                             Security Group Rule for the DB Server
*
*/

resource "ibm_is_security_group_rule" "ssh_db" {
  group     = ibm_is_security_group.db.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = "22"
    port_max = "22"
  }
}


resource "ibm_is_security_group" "lb_sg" {
  name           = "${var.prefix}lb-sg"
  vpc            = var.vpc_id
  resource_group = var.resource_group
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

/**
*
* Output Variable for loadbalancer Security Group
* This variable will return the loadbalancer Security Group ID 
* 
**/

output "lb_sg" {
  value       = ibm_is_security_group.lb_sg.id
  description = "Security Group id for the load balancer"
}