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
  name           = "${var.prefix}web-lb"
  resource_group = var.resource_group
  type           = "public"
  subnets        = var.web_subnet
  security_groups = [var.lb_sg]
}

/**
* Output Variable
* Element : Load Balancer
* LB ID For Web
* This variable will expose the LB ID for web
**/
output "web_lb_id" {
  value       = ibm_is_lb.web_lb.id
  description = "Web load balancer ID"
}

/**
* Output Variable
* Element : Load Balancer IP
* LB IP For Web
* This variable will expose the LB IP for web
**/
output "web_lb_ip" {
  value       = ibm_is_lb.web_lb.public_ips
  description = "Web load balancer ID"
}

/**
* Output Variable
* Element : Load Balancer Hostname
* LB ID For Web
* This variable output the Load Balancer's Hostname for web
**/
output "web_lb_hostname" {
  value       = ibm_is_lb.web_lb.hostname
  description = "Web load balancer Hostname"
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
  lb                 = ibm_is_lb.web_lb.id
  name               = "${var.prefix}web-pool"
  protocol           = var.lb_protocol["80"]
  algorithm          = var.lb_algo["rr"]
  health_delay       = "5"
  health_retries     = "2"
  health_timeout     = "2"
  health_type        = var.lb_protocol["80"]
  health_monitor_url = "/"
  depends_on         = [ibm_is_lb.web_lb]

}

/**
* Output Variable
* Element : LB Pool
* Pool ID For Web
* This variable will expose the Pool Id
**/
output "web_lb_pool_id" {
  value       = ibm_is_lb_pool.web_pool.id
  description = "Web load balancer pool ID"
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
