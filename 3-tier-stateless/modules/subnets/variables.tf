/**
#################################################################################################################
*                           Variable Section for the Security Group Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/
variable "bastion_ip_count" {
  description = "IP count is the total number of total_ipv4_address_count"
  type        = any
  default     = 8
}

variable "ip_count" {
  description = "Enter total number of IP Address for each subnet"
  type        = any
}

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

variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
