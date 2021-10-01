/**
#################################################################################################################
*
*                               Load Balancer Section for the App LB
*                                 Start Here of the App LB Section 
*
#################################################################################################################
*/

/**
* Load Balancer For App
**/
resource "ibm_is_lb" "app_lb" {
  name            = "${var.prefix}app-lb"
  resource_group  = var.resource_group_id
  type            = "private"
  subnets         = var.app_subnet
  security_groups = [var.lb_sg]
}

/**
* Load Balancer Listener For App
**/
resource "ibm_is_lb_listener" "app_listener" {
  lb           = ibm_is_lb.app_lb.id
  protocol     = var.lb_protocol["80"]
  port         = var.alb_port
  default_pool = ibm_is_lb_pool.app_pool.id
  depends_on   = [ibm_is_lb_pool.app_pool]
}

/**
* Load Balancer Pool For App
**/
resource "ibm_is_lb_pool" "app_pool" {
  lb                  = ibm_is_lb.app_lb.id
  name                = "${var.prefix}app-pool"
  protocol            = var.lb_protocol["80"]
  algorithm           = var.lb_algo["rr"]
  health_delay        = "5"
  health_retries      = "2"
  health_timeout      = "2"
  health_type         = var.lb_protocol["80"]
  health_monitor_url  = "/"
  health_monitor_port = var.alb_port
  depends_on          = [ibm_is_lb.app_lb]
}

/**
* Load Balancer Pool Member For App
**/
resource "ibm_is_lb_pool_member" "app_lb_member" {
  count          = length(var.total_instance) * length(var.zones)
  lb             = ibm_is_lb.app_lb.id
  pool           = ibm_is_lb_pool.app_pool.id
  port           = var.lb_port_number["http"]
  target_address = element(var.app_target, count.index)
  depends_on     = [ibm_is_lb_listener.app_listener, var.app_vsi]
}

/**               
#################################################################################################################
*                              End of the App Load Balancer Section 
#################################################################################################################
**/
