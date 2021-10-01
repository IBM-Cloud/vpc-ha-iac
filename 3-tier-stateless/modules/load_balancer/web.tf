/**
#################################################################################################################
*
*                               Load Balancer Section for the Web LB
*                                 Start Here of the Web LB Section 
*
#################################################################################################################
*/

/**
* Load Balancer For Web
**/
resource "ibm_is_lb" "web_lb" {
  name            = "${var.prefix}web-lb"
  resource_group  = var.resource_group_id
  type            = "public"
  subnets         = var.web_subnet
  security_groups = [var.lb_sg]
}

/**
* Load Balancer Listener For Web
**/
resource "ibm_is_lb_listener" "web_listener" {
  lb           = ibm_is_lb.web_lb.id
  protocol     = var.lb_protocol["80"]
  port         = "80"
  default_pool = ibm_is_lb_pool.web_pool.id
  depends_on   = [ibm_is_lb_pool.web_pool]
}

/**
* Load Balancer Pool For Web
**/
resource "ibm_is_lb_pool" "web_pool" {
  lb                  = ibm_is_lb.web_lb.id
  name                = "${var.prefix}web-pool"
  protocol            = var.lb_protocol["80"]
  algorithm           = var.lb_algo["rr"]
  health_delay        = "5"
  health_retries      = "2"
  health_timeout      = "2"
  health_type         = var.lb_protocol["80"]
  health_monitor_url  = "/"
  health_monitor_port = "80"
  depends_on          = [ibm_is_lb.web_lb]

}

/**
* Load Balancer Pool Member For Web
**/
resource "ibm_is_lb_pool_member" "web_lb_member" {
  count          = length(var.total_instance) * length(var.zones)
  lb             = ibm_is_lb.web_lb.id
  pool           = ibm_is_lb_pool.web_pool.id
  port           = var.lb_port_number["http"]
  target_address = element(var.web_target, count.index)
  depends_on     = [ibm_is_lb_listener.web_listener, var.web_vsi]
}


# /**               
# #################################################################################################################
# *                              End of the Web Load Balancer Section 
# #################################################################################################################
# **/
