###################################################################################################
###################################################################################################
#####         This Terraform file defines the variables used in Load Balancer Module         ######
#####                                     Load Balancer Module                               ######
###################################################################################################
###################################################################################################


/**
* Name: lb_type_private
* Desc: This variable will hold the Load Balancer type as private
* Type: String
**/
variable "lb_type_private" {
  description = "This variable will hold the Load Balancer type as private"
  default     = "private"
}

/**
* Name: lb_type_public
* Desc: This variable will hold the Load Balancer type as public
* Type: String
**/
variable "lb_type_public" {
  description = "This variable will hold the Load Balancer type as public"
  default     = "public"
}

/**
* Name: lb_protocol
* Type: map(any)
* Description: lbaas Protocols
**/
variable "lb_protocol" {
  description = "lbaaS protocols"
  type        = map(any)
  default = {
    "80"     = "http"
    "443"    = "https"
    "l4-tcp" = "tcp"
  }
}

/**
* Name: lb_algo
* Type: map(any)
* Description: lbaaS backend distribution algorithm
**/
variable "lb_algo" {
  description = "lbaaS backend distribution algorithm"
  type        = map(any)
  default = {
    "rr"      = "round_robin"
    "wrr"     = "weighted_round_robin"
    "least-x" = "least_connections"
  }
}

/**
* Name: lb_port_number
* Type: map(any)
* Description: Declare lbaaS pool member port number
**/
variable "lb_port_number" {
  description = "declare lbaaS pool member port number"
  type        = map(any)
  default = {
    "http"   = "80"
    "https"  = "443"
    "custom" = "xxx"
  }
}

/**
* Name: alb_port
* Type: number
* Description: This is the Application load balancer listener port
**/
variable "alb_port" {
  description = "This is the Application load balancer listener port"
  type        = number
  default     = 80
}

