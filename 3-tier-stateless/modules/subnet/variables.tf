/**
#################################################################################################################
*                           Variable Section for the Security Group Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
  * IP Count for the subnet
  * Value of ip_count will be from following 
  * 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 and 16384
  * Name: ip_count
  * Type: map(any)
  * Description = "This map contains total number of IP Address for each subnet present in each tier web, app and db"
  */
variable "ip_count" {
  description = "Enter total number of IP Address for each subnet"
  type        = any
}

/**
* Name: resource_group_id
* Type: String
* Description: Please enter the Resource Group ID to be used for creation of the resources
*/
variable "resource_group_id" {
  description = "Resource Group Id is used to seperated the resources in a group."
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
  type        = any
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
* Name: public_gateway_ids
* Desc: List of ids of all the public gateways where subnets will get attached
* Type: list(any)
**/
variable "public_gateway_ids" {
  description = "List of ids of all the public gateways where subnets will get attached"
  type        = list(any)
}

/**
* Name: db_vsi_count
* Type: number
* Desc: Total Database instances that will be created in the user specified region.
**/
variable "db_vsi_count" {
  description = "Total Database instances that will be created in the user specified region."
  type        = number
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
