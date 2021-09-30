/**
#################################################################################################################
*                           Variable Section for the Public Gateways Module.
*                                 Start Here of the Variable Section 
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
  description = "Prefix for all the resources."
  type        = string
}

/**
* Name: vpc_id
* Type: String
* Description: This is the vpc id which will be used for subnet module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: zones
* Desc: List of Availability Zones where bastion resource will be created
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
