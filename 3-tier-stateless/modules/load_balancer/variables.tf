/**
#################################################################################################################
*                           Variable Section for the Security Group Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group
* Type: String
* Desc: Resource Group ID is used to seperated the resources in a group.
*/
variable "resource_group_id" {
  description = "Resource Group Id is used to seperated the resources in a group."
  type        = string
}

/**
* Name: prefix
* Type: String
* Desc: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "Prefix for all the resources."
  type        = string
}

/**
* Name: vpc_id
* Type: String
* Desc: This is the vpc id which will be used for loadbalncer module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = any
}

/**
* Name: web_subnet
* Type: any
* Desc: This variable will return the objects for the web subnets of all zones.
**/
variable "web_subnet" {
  description = "Web subnets Ids. This is required parameter"
  type        = any
}

/**
* Name: app_subnet
* Type: any
* Desc: This variable will return the objects for the app subnets of all zones.
**/
variable "app_subnet" {
  description = "App subnets Ids. This is required parameter"
  type        = any
}

/**
* Name: total_instance
* Type: any
* Desc: Total instances that will be created per zones per tier.
**/
variable "total_instance" {
  type        = any
  description = "Total number of instances that will be created. "
}

/**
* Name: web_target
* Type: any
* Desc: Target interface address of the Web server 
**/
variable "web_target" {
  type        = any
  description = "Target interface address of the web server "
}

/**
* Name: app_target
* Type: any
* Desc: Target interface address of the App server 
**/
variable "app_target" {
  type        = any
  description = "Target interface address of the app server "
}

/**
* Name: web_vsi
* Type: any
* Desc: VSI reference for web from the instance module 
**/
variable "web_vsi" {
  type        = any
  description = "VSI reference for web from the instance module"
}

/**
* Name: app_vsi
* Type: any
* Desc: VSI reference for app from the instance module 
**/
variable "app_vsi" {
  type        = any
  description = "VSI reference for app from the instance module"
}

/**
* Name: lb_protocol
* Type: map(any)
* Desc: lbaas Protocols
**/
variable "lb_protocol" {
  description = "lbaaS protocols"
  type        = map(any)
}

/**
* Name: lb_algo
* Type: map(any)
* Desc: lbaaS backend distribution algorithm
**/
variable "lb_algo" {
  description = "lbaaS backend distribution algorithm"
  type        = map(any)
}

/**
* Name: lb_port_number
* Type: map(any)
* Desc: Declare lbaaS pool member port number
**/
variable "lb_port_number" {
  description = "declare lbaaS pool member port numbert"
  type        = map(any)
}

/**
* Name: zones
* Type: map(any)
* Desc: Region and zones mapping
**/
variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
}

/**
* Name: lb_sg
* Type: string
* Desc: Load balancer security group id to be attached with load balancers
**/
variable "lb_sg" {
  type        = any
  description = "Load Balancer Security Group "
}

/**
* Name: alb_port
* Type: number
* Desc: This is the Application load balancer listener port
**/
variable "alb_port" {
  description = "This is the Application load balancer listener port"
  type        = number
}


/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
