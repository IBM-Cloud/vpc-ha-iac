/**
#################################################################################################################
*                       Load Balancer Output Variable Section
*                     Start Here for the Output Variable Section 
#################################################################################################################
**/


/**
* Output Variable
* Element : LB Public IP
* Public IP address for the Web Load Balancer
* This variable will return IP address for the Web Load Balancer
**/
output "lb_public_ip" {
  value = merge(
    { "WEB_SERVER" = ibm_is_lb.web_lb.public_ips }
  )
  description = "Public IP for Web Server"
}

/**
* Output Variable
* Element : LB Private IP
* Private IP address for the App and DB Load Balancer
* This variable will return IP address for the App and DB Load Balancer
**/
output "lb_private_ip" {
  value = merge(
    { "APP_SERVER" = ibm_is_lb.app_lb.private_ips },
  )
  description = "Private IP for App and DB Server"
}

/**
* Output Variable
* Element : LB DNS
* DNS address for the App, DB and Web Load Balancer
* This variable will return DNS for the App and DB Load Balancer
**/
output "lb_dns" {
  value = merge(
    { "APP_SERVER" = ibm_is_lb.app_lb.hostname },
    { "WEB_SERVER" = ibm_is_lb.web_lb.hostname }
  )
  description = "Private IP for App, DB and Web Server"
}

/**
* Output Variable: objects
* Element : objects
* This variable will return the objects of LB, LB Pool and LB Listeners for app, db and web tiers.
**/
output "objects" {
  description = "This variable will contains the objects of LB, LB Pool and LB Listeners. "
  value = {
    "lb" = {
      "app" = ibm_is_lb.app_lb,
      "web" = ibm_is_lb.web_lb
    },
    "pool" = {
      "app" = ibm_is_lb_pool.app_pool,
      "web" = ibm_is_lb_pool.web_pool
    },
    "listener" = {
      "app" = ibm_is_lb_listener.app_listener,
      "web" = ibm_is_lb_listener.web_listener
    }
  }
}
