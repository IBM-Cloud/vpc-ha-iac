/**
#################################################################################################################
*                           Variable Section for the Load Balancer Module.
*                                 Start Here for the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group_id
* Type: String
*/
variable "resource_group_id" {
  description = "Resource Group ID is used to seperate the resources in a group."
  type        = string
}

/**
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "This is the prefix text that will be prepended in every resource name created for this module."
  type        = string
}

/**
* Name: lb_type_private
* Desc: This variable will hold the Load Balancer type as private
* Type: String
**/
variable "lb_type_private" {
  description = "This variable will hold the Load Balancer type as private"
  type        = string
}

/**
* Name: lb_type_public
* Desc: This variable will hold the Load Balancer type as public
* Type: String
**/
variable "lb_type_public" {
  description = "This variable will hold the Load Balancer type as public"
  type        = string
}


/**
* Name: alb_port
* Type: number
* Description: This is the Application load balancer listener port
**/
variable "alb_port" {
  description = "This is the Application load balancer listener port"
  type        = number
}

/**
* Name: vpc_id
* Type: String
* Description: This is the vpc id which will be used for loadbalncer module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: subnets
* Type: list
* Description: Map of subnet objects
**/
variable "subnets" {
  description = "All subnet objects. This is required parameter"
  type = object({
    app = list(any)
    web = list(any)
  })
}

/**
* Name: lb_sg
* Type: string
* Description: Load balancer security group id to be attached with load balancers
**/
variable "lb_sg" {
  description = "Load Balancer Security Group"
  type        = string
}

/**
* Name: lb_protocol
* Type: map(any)
* Description: lbaas Protocols
**/
variable "lb_protocol" {
  description = "lbaaS protocols"
  type        = map(any)
}

/**
* Name: lb_algo
* Type: map(any)
* Description: lbaaS backend distribution algorithm
**/
variable "lb_algo" {
  description = "lbaaS backend distribution algorithm"
  type        = map(any)
}

/**
* Name: lb_port_number
* Type: map(any)
* Description: Declare lbaaS pool member port number
**/
variable "lb_port_number" {
  description = "declare lbaaS pool member port number"
  type        = map(any)
}

/**
* Name: zones
* Type: map(any)
* Description: Region and zones mapping
**/
variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
