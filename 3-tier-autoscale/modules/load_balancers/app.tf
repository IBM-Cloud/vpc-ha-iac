/**
#################################################################################################################
*
*                               Load Balancer Section for App Tier
*                                 Start Here for the App LB Section 
*
#################################################################################################################
*/

/**
* App Load Balancer
* Element : app_lb
* This resource will create the Private App Load Balancer for App servers
* This will balance load between all the app servers
**/
resource "ibm_is_lb" "app_lb" {
  name            = "${var.prefix}app-lb"
  resource_group  = var.resource_group_id
  type            = var.type_private
  subnets         = var.subnets["app"].*.id
  security_groups = [var.lb_sg]
}

/**
* App Load Balancer Pool
* Element : app_pool
* This resource will create the App Loadbalancer Pool
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
* App Load Balancer Listener
* Element : app_listener
* This resource will create the App Loadbalancer Listener
**/
resource "ibm_is_lb_listener" "app_listener" {
  lb           = ibm_is_lb.app_lb.id
  protocol     = var.lb_protocol["80"]
  port         = var.alb_port
  default_pool = ibm_is_lb_pool.app_pool.pool_id
  depends_on   = [ibm_is_lb.app_lb, ibm_is_lb_pool.app_pool]
}

# /**               
# #################################################################################################################
# *                              End of the App Load Balancer Section 
# #################################################################################################################
# **/

