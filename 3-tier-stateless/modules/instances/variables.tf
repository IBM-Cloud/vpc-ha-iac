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

variable "web_subnet" {
  description = "Web subnets Ids. This is required parameter"
  type        = any
}

variable "db_subnet" {
  description = "DB subnets Ids. This is required parameter"
  type        = any
}

variable "app_subnet" {
  description = "App subnets Ids. This is required parameter"
  type        = any
}

variable "web_sg" {
  description = "Web Security Group"
  type        = any
}

variable "db_sg" {
  description = "DB Security Group"
  type        = any
}

variable "app_sg" {
  description = "App Security Group"
  type        = any
}

variable "wlb_id" {
  description = "Web Load Balancer ID"
  type        = any
}

variable "dlb_id" {
  description = "DB Load Balancer ID"
  type        = any
}

variable "alb_id" {
  description = "App Load Balancer ID"
  type        = any
}

variable "ssh_key" {
  description = "ssh keys for the vsi"
  type        = any
}

/**
* Name: web_image
* Desc: This variable will hold the image name for web instance
* Type: String
**/
variable "web_image" {
  default = "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"
}

/**
* Name: app_image
* Desc: This variable will hold the image name for app instance
* Type: String
**/
variable "app_image" {
  default = "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"
}

/**
* Name: db_image
* Desc: This variable will hold the image name for db instance
* Type: String
**/
variable "db_image" {
  default = "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"
}

/**
* Name: bastion_image
* Desc: This variable will hold the image name for bastion instance
* Type: String
**/
variable "bastion_image" {
  default = "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"
}

/**
* Name: web_profile
* Desc: This variable will hold the image profile name for web instance
* Type: String
**/
variable "web_profile" {
  default = "cx2-2x4"
}

/**
* Name: app_profile
* Desc: This variable will hold the image profile name for app instance
* Type: String
**/
variable "app_profile" {
  default = "cx2-2x4"
}

/**
* Name: db_profile
* Desc: This variable will hold the image profile name for db instance
* Type: String
**/
variable "db_profile" {
  default = "cx2-2x4"
}

/**
* Name: bastion_profile
* Desc: This variable will hold the image profile name for bastion instance
* Type: String
**/
variable "bastion_profile" {
  default = "cx2-2x4"
}


variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
}

variable "total_instance" {
  type        = any
  description = "Please enter the total number of instances you want to create in each zones."
}

variable "bastion_sg" {
  type        = any
  description = "Bastion Security Group "
}

variable "bastion_subnet" {
  type        = any
  description = "Bastion Subnet ID "
}

/**
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/
