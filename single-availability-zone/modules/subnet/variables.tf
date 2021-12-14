/**
#################################################################################################################
*                           Variable Section for the Subnets Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
  * IP Count for the subnets web, app and db tier
  * Value of ip_count will be from following 
  * 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 and 16384
  * Name: ip_count
  * Type: map(any)
  * Desc: This map contains total number of IP Address for each subnet present in each tier web, app and db
  */
variable "ip_count" {
  description = "This map contains total number of IP Address for each subnet present in each tier web, app and db"
  type        = map(any)
}

/**
* Name: resource_group_id
* Desc: Resource Group ID is used to seperate the resources in a group.
* Type: String
*/
variable "resource_group_id" {
  description = "Resource Group ID is used to seperate the resources in a group."
  type        = string
}

/**
* Name: prefix
* Desc: This is the prefix text that will be prepended in every resource name created by this script.
* Type: String
**/
variable "prefix" {
  description = "Prefix for all the resources."
  type        = string
}

/**
* Name: vpc_id
* Desc: This is the vpc id which will be used for subnet module. We are passing this vpc_id from main.tf
* Type: String
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: zone
* Desc: The zone where the subnet will be created
* Type: string
**/
variable "zone" {
  description = "The zone where the subnet will be created"
  type        = string
}


/**
* Name: public_gateway_id
* Desc: Id of the public gateway where subnets will get attached
* Type: list(any)
**/
variable "public_gateway_id" {
  description = "Id of the public gateway where subnets will get attached"
  type        = string
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
