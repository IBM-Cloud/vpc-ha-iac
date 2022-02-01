/**
#################################################################################################################
*
*                               Load Balancer Section for Web Tier
*                                 Start Here for the Web LB Section 
*
#################################################################################################################
*/

/**
* Web Load Balancer
* Element : web_lb
* This resource will create the Public Web Load Balancer for Web servers
* This will balance load between all the web servers
**/
resource "ibm_is_lb" "web_lb" {
  name            = "${var.prefix}web-lb"
  resource_group  = var.resource_group_id
  type            = var.lb_type_public
  subnets         = var.subnets["web"].*.id
  security_groups = [var.lb_sg]
}

/**
* Web Load Balancer Pool
* Element : web_pool
* This resource will create the Web Loadbalancer Pool
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
  health_monitor_url  = "/wp-admin/install.php"
  health_monitor_port = "80"
  depends_on          = [ibm_is_lb.web_lb]

}

/**
* Web Load Balancer Listener
* Element : web_listener
* This resource will create the Web Loadbalancer Listener
**/
resource "ibm_is_lb_listener" "web_listener" {
  lb           = ibm_is_lb.web_lb.id
  protocol     = var.lb_protocol["80"]
  port         = "80"
  default_pool = ibm_is_lb_pool.web_pool.pool_id
  depends_on   = [ibm_is_lb.web_lb, ibm_is_lb_pool.web_pool]
}


# /**               
# #################################################################################################################
# *                              End of the Web Load Balancer Section 
# #################################################################################################################
# **/

