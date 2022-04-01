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
* Name: db_subnet
* Type: any
* Desc: This variable will return the objects for the db subnets of all zones.
**/
variable "db_subnet" {
  description = "DB subnets Ids. This is required parameter"
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
* Name: web_sg
* Type: any
* Desc: This variable will return the Web Security Group ID.
**/
variable "web_sg" {
  description = "Web Security Group"
  type        = any
}

/**
* Name: db_sg
* Type: any
* Desc: This variable will return the DB Security Group ID.
**/
variable "db_sg" {
  description = "DB Security Group"
  type        = any
}

/**
* Name: app_sg
* Type: any
* Desc: This variable will return the App Security Group ID.
**/
variable "app_sg" {
  description = "App Security Group"
  type        = any
}

/**
* Name: wlb_id
* Type: any
* Desc: This variable will return the Web Load Balancer ID.
**/
variable "wlb_id" {
  description = "Web Load Balancer ID"
  type        = any
}

/**
* Name: alb_id
* Type: any
* Desc: This variable will return the App Load Balancer ID.
**/
variable "alb_id" {
  description = "App Load Balancer ID"
  type        = any
}

/**
* Name: ssh_key
* Type: any
* Desc: Dynamic ssh_key generated on the Bastion Server. It will ensure the connectivity
*     from Bastion server to this VSI
**/
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
  description = " This variable will hold the image name for web instance"
  type        = string
}

/**
* Name: app_image
* Desc: This variable will hold the image name for app instance
* Type: String
**/
variable "app_image" {
  description = "This variable will hold the image name for app instance"
  type        = string
}

/**
* Name: db_image
* Desc: This variable will hold the image name for db instance
* Type: String
**/
variable "db_image" {
  description = "This variable will hold the image name for db instance"
  type        = string
}

/**
* Name: web_profile
* Desc: This variable will hold the image profile name for web instance
* Type: String
**/
variable "web_profile" {
  description = "This variable will hold the image profile name for web instance"
  type        = string
}

/**
* Name: app_profile
* Desc: This variable will hold the image profile name for app instance
* Type: String
**/
variable "app_profile" {
  description = "This variable will hold the image profile name for app instance"
  type        = string
}

/**
* Name: db_profile
* Desc: This variable will hold the image profile name for db instance
* Type: String
**/
variable "db_profile" {
  description = "This variable will hold the image profile name for db instance"
  type        = string
}

/**
* Name: zones
* Desc: List of Availability Zones where compute resource will be created
* Type: list(any)
**/
variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
}

/**
* Name: total_instance
* Type: any
* Desc: Total instances that will be created per zones per tier.
**/
variable "total_instance" {
  type        = any
  description = "Please enter the total number of instances you want to create in each zones."
}

/**
* Name: bastion_sg
* Type: any
* Desc: Bastion Server Security Group ID.
**/
variable "bastion_sg" {
  type        = any
  description = "Bastion Security Group "
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
*                               End of the Variable Section 
#################################################################################################################
**/
