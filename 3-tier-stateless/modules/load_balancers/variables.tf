/**
#################################################################################################################
*                           Variable Section for the Security Group Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

variable "resource_group" {
  description = "Resource Group Name is used to separate the resources in a group."
  type        = string
}

variable "prefix" {
  description = "Prefix for all the resources."
  type        = string
}

variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = any
}

variable "web_subnet" {
  description = "Web subnets Ids. This is required parameter"
  type        = any
}

variable "app_subnet" {
  description = "App subnets Ids. This is required parameter"
  type        = any
}

variable "db_subnet" {
  description = "DB subnets Ids. This is required parameter"
  type        = any
}

variable "total_instance" {
  type        = any
  description = "Total number of instances that will be created. "
}

variable "web_target" {
  type        = any
  description = "Target interface address of the web server "
}

variable "app_target" {
  type        = any
  description = "Target interface address of the app server "
}

variable "db_target" {
  type        = any
  description = "Target interface address of the DB server "
}
variable "web_vsi" {
  type        = any
  description = "VSI reference for web from the instance module"
}
variable "app_vsi" {
  type        = any
  description = "VSI reference for app from the instance module"
}
variable "db_vsi" {
  type        = any
  description = "VSI reference for db from the instance module"
}

variable "lb_protocol" {
  description = "lbaaS protocols"
  type        = map(any)
  default = {
    "80"     = "http"
    "443"    = "https"
    "l4-tcp" = "tcp"
  }
}

variable "lb_algo" {
  description = "LB backend distribution algorithm"
  type        = map(any)
  default = {
    "rr"      = "round_robin"
    "wrr"     = "weighted_round_robin"
    "least-x" = "least_connections"
  }
}

variable "lb_port_number" {
  description = "Declare LB pool member port number"
  type        = map(any)
  default = {
    "http"   = "80"
    "https"  = "443"
    "custom" = "xxx"
  }
}

variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
}

variable "lb_sg" {
  type        = any
  description = "Load Balancer Security Group "
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
