/**
#################################################################################################################
*                           Variable Section for the Transit Gateway Module.
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
* Name: location
* Type: String
* Description: Transit Gateway creating region.
**/
variable "location" {
  description = "Required location to create transit gateway"
  type        = string
}

/**
* Name: vpc_crn_region1
* Type: String
* Description: This is the vpc crn id which will be used for transit gateway module. We are passing this network_id_region_1 from main.tf
**/
variable "vpc_crn_region1" {
  description = "Required Region-1 VPC CRN number"
  type        = string
}

/**
* Name: vpc_crn_region2
* Type: String
* Description: This is the vpc crn id which will be used for transit gateway module. We are passing this network_id_region_2 from main.tf
**/
variable "vpc_crn_region2" {
  description = "Required Region-2 VPC CRN number"
  type        = string
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
