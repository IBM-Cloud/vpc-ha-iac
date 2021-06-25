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

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
