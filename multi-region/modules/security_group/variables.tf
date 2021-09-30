/**
#################################################################################################################
*                           Variable Section for the Security Group Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group_id
* Type: String
*/
variable "resource_group_id" {
  description = "Resource Group Name is used to seperate the resources in a group."
  type        = string
}

/**
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "Prefix for all the resources."
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
* Name: dlb_port
* Type: number
* Description: This is the DB load balancer listener port
**/
variable "dlb_port" {
  description = "This is the DB load balancer listener port"
  type        = number
}

/**
* Name: vpc_id
* Type: String
* Description: This is the vpc id which will be used for security group module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: app_os_type
* Desc: OS image to be used [windows | linux] for App Server
* Type: string
**/
variable "app_os_type" {
  description = "OS image to be used [windows | linux] for App Server"
  type        = string
}

/**
* Name: web_os_type
* Desc: OS image to be used [windows | linux] for Web Server
* Type: string
**/
variable "web_os_type" {
  description = "OS image to be used [windows | linux] for Web Server"
  type        = string
}

/**
* Name: db_os_type
* Desc: OS image to be used [windows | linux] for DB Server
* Type: string
**/
variable "db_os_type" {
  description = "OS image to be used [windows | linux] for DB Server"
  type        = string
}

/**
* Name: bastion1_subnet
* Desc: Bastion 1 subnet CIDR Range to be whitelisted in security groups
* Type: any
**/
variable "bastion1_subnet" {
  description = "Bastion 1 subnet CIDR Range"
  type        = any
}

/**
* Name: bastion2_subnet
* Desc: Bastion 2 subnet CIDR Range to be whitelisted in security groups
* Type: any
**/
variable "bastion2_subnet" {
  description = "Bastion 2 subnet CIDR Range"
  type        = any
}

/**
* Name: db_region1_subnets
* Desc: List of CIDR ranges where DB resources will be created
* Type: list(any)
**/
variable "db_region1_subnets" {
  description = "Region1 DB subnets CIDR Range"
  type        = any
}

/**
* Name: db_region2_subnets
* Desc: List of CIDR ranges where DB resources will be created
* Type: list(any)
**/
variable "db_region2_subnets" {
  description = "Region2 DB subnets CIDR Range"
  type        = any
}

/**
* Name: zones
* Desc: List of Availability Zones where DB resource will be created
* Type: list(any)
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
