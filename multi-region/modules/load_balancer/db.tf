/**
#################################################################################################################
*
*                               Load Balancer Section for DB Tier
*                                 Start Here for the DB LB Section 
*
#################################################################################################################
*/

/**
* DB Load Balancer
* Element : db_lb
* This resource will create the Private DB Load Balancer for DB servers
* This will balance load between all the DB servers
**/
resource "ibm_is_lb" "db_lb" {
  name            = "${var.prefix}db-lb"
  resource_group  = var.resource_group_id
  type            = var.lb_type_private
  subnets         = var.subnets["db"].*.id
  security_groups = [var.lb_sg]
}

/**
* DB Load Balancer Pool
* Element : db_pool
* This resource will create the DB Loadbalancer Pool
**/
resource "ibm_is_lb_pool" "db_pool" {
  lb                  = ibm_is_lb.db_lb.id
  name                = "${var.prefix}db-pool"
  protocol            = var.lb_protocol["80"]
  algorithm           = var.lb_algo["rr"]
  health_delay        = "5"
  health_retries      = "2"
  health_timeout      = "2"
  health_type         = var.lb_protocol["80"]
  health_monitor_url  = "/"
  health_monitor_port = var.dlb_port
  depends_on          = [ibm_is_lb.db_lb]

}

/**
* DB Load Balancer Listener
* Element : db_listener
* This resource will create the DB Loadbalancer Listener
**/
resource "ibm_is_lb_listener" "db_listener" {
  lb           = ibm_is_lb.db_lb.id
  protocol     = var.lb_protocol["80"]
  port         = var.dlb_port
  default_pool = ibm_is_lb_pool.db_pool.pool_id
  depends_on   = [ibm_is_lb.db_lb, ibm_is_lb_pool.db_pool]
}

/**
* DB Load Balancer Pool Member
* Element : db_lb_member
* This resource will create the DB Loadbalancer Pool Members
**/
resource "ibm_is_lb_pool_member" "db_lb_member" {
  count          = length(var.db_vsi_count) * length(var.zones)
  lb             = ibm_is_lb.db_lb.id
  pool           = ibm_is_lb_pool.db_pool.id
  port           = var.lb_port_number["http"]
  target_address = element(var.db_target, count.index)
  depends_on     = [ibm_is_lb_listener.db_listener, var.db_vsi]
}


# /**               
# #################################################################################################################
# *                              End of the DB Load Balancer Section 
# #################################################################################################################
# **/
