/**
#################################################################################################################
*                           Variable Section for the DB Instance Module.
*                                 Start Here for the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group_id
* Type: String
* Description: Resource Group ID to be used for resources creation
*/
variable "resource_group_id" {
  description = "Resource Group ID"
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
* Description: This is the vpc id which will be used for instance module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: subnets
* Type: list
* Description: DB Subnet Ids
**/
variable "subnets" {
  description = "DB subnets Ids. This is required parameter"
  type        = list(any)
}

/**
* Name: db_sg
* Type: string
* Description: Security group id to be attached with DB server
**/
variable "db_sg" {
  description = "DB Security Group"
  type        = string
}

/**
* Name: ssh_key
* Type: string
* Description: ssh key to be attached with DB servers
**/
variable "ssh_key" {
  description = "ssh keys for the vsi"
  type        = list(any)
}

/**
* Name: db_image
* Desc: This variable will hold the image name for db instance
* Type: String
**/
variable "db_image" {
  description = "Image for DB VSI"
  type        = string
}

/**
* Name: db_profile
* Desc: This variable will hold the image profile name for db instance
* Type: String
**/
variable "db_profile" {
  description = "DB Profile"
  type        = string
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
* Name: bandwidth
* Desc: Input/Output per seconds in GB
* Type: number
**/
variable "bandwidth" {
  description = "Bandwidth per second in GB. The possible values are 3, 5 and 10"
  type        = number
  validation {
    condition     = contains(["3", "5", "10", 3, 5, 10], var.bandwidth)
    error_message = "Error: Incorrect value for bandwidth. Allowed values are 3, 5 and 10."
  }
}


/**
* Name: tiered_profiles
* Desc: Tiered profiles for Input/Output per seconds in GBs
* Type: map(any)
**/
variable "tiered_profiles" {
  description = "Tiered profiles for Input/Output per seconds in GBs"
  type        = map(any)
}

/**
* Name: data_vol_size
* Desc: Storage size in GB
* Type: number
**/
variable "data_vol_size" {
  description = "Storage size in GB. The value should be between 10 and 2000"
  type        = number
  validation {
    condition     = var.data_vol_size >= 10 && var.data_vol_size <= 2000
    error_message = "Error: Incorrect value for size. Allowed size should be between 10 and 2000 GB."
  }
}

/**
* Name: zones
* Type: list(any)
* Description: Region and zones mapping
**/
variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
}

/**
* Name: db_name
* Type: string
* Description: Database will be created with the specified name
**/
variable "db_name" {
  description = "Database will be created with the specified name"
  type        = string
}

/**
* Name: db_password
* Type: string
* Description: Admin user will be created with the specified password
**/
variable "db_password" {
  description = "Admin user will be created with the specified password"
  type        = string
}


/**
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/
