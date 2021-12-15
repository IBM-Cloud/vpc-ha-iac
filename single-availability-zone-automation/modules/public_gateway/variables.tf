/**
#################################################################################################################
*                           Variable Section for the Public Gateway Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/


/**
* Name: resource_group_id
* Type: String
* Desc: "Resource Group ID is used to seperate the resources in a group."
*/
variable "resource_group_id" {
  description = "Resource Group ID is used to seperate the resources in a group."
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
* Desc: This is the vpc id which will be used for public gateway module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: zone
* Desc: The zone where the public gateway will be created
* Type: string
**/
variable "zone" {
  description = "The zone where the public gateway will be created"
  type        = string
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
