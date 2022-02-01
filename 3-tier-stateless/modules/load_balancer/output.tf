/**
#################################################################################################################
*                                 Load Balancers Output Variable Section
#################################################################################################################
**/

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
* Output Variable
* Element : Load Balancer
* LB ID For App
* This variable will expose the LB ID for App
**/
output "app_lb_id" {
  value       = ibm_is_lb.app_lb.id
  description = "App load balancer ID"
}

/**
* Output Variable
* Element : Load Balancer IP
* LB IP For App
* This variable will expose the LB IP for App
**/
output "app_lb_ip" {
  value       = ibm_is_lb.app_lb.private_ips
  description = "App load balancer IP"
}

/**
* Output Variable
* Element : Load Balancer Hostname
* LB Hostname For App
* This variable output the Load Balancer's Hostname for App
**/
output "app_lb_hostname" {
  value       = ibm_is_lb.app_lb.hostname
  description = "App load balancer Hostname"
}

/**
* Output Variable
* Element : LB Pool
* Pool ID For App
* This variable will expose the Pool Id
**/
output "app_lb_pool_id" {
  value       = ibm_is_lb_pool.app_pool.id
  description = "App load balancer pool ID"
}

/**               
#################################################################################################################
*                                   End of the Output Section 
#################################################################################################################
**/