###################################################################################################
###################################################################################################
#####           This Terraform file defines the variables used in Instance Module            ######
#####                                       Instance Module                                  ######
###################################################################################################
###################################################################################################

/**
* Name: db_image
* Type: String
* Description: This is the image id used for DB VSI.
**/
variable "db_image" {
  description = "Custom image id for the Database VSI"
  type        = string
}

/**
* Name: bandwidth
* Desc: Input/Output per seconds in GB. It will be used for the extra storage volume attached with the DB servers.
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
* Name: data_vol_size
* Desc: Volume Storage size in GB. It will be used for the extra storage volume attached with the DB servers.
* Type: number
**/
variable "data_vol_size" {
  description = "Storage size in GB. The value should be between 10 and 2000"
  type        = number
  default     = 10
  validation {
    condition     = var.data_vol_size >= 10 && var.data_vol_size <= 2000
    error_message = "Error: Incorrect value for size. Allowed size should be between 10 and 2000 GB."
  }
}


/**
* Name: db_profile
* Type: String
* Description: Hardware configuration profile for the Database VSI.
**/
variable "db_profile" {
  description = "Hardware configuration profile for the Database VSI."
  type        = string
  default     = "cx2-2x4"
}

/**
* Name: tiered_profiles
* Desc: Tiered profiles for Input/Output per seconds in GBs
* Type: map(any)
**/
variable "tiered_profiles" {
  description = "Tiered profiles for Input/Output per seconds in GBs"
  type        = map(any)
  default = {
    "3"  = "general-purpose"
    "5"  = "5iops-tier"
    "10" = "10iops-tier"
  }
}

/**
* Name: db_vsi_count
* Type: number
* Desc: Total Database instances that will be created in the user specified region.
*       We have kept the default value to be 2 here. The servers will be created in different zones and it cannot be more than 3.
**/
variable "db_vsi_count" {
  description = "Total Database instances that will be created in the user specified region."
  type        = number
  default     = 2
  validation {
    condition     = var.db_vsi_count <= 3
    error_message = "Database VSI count should be less than or equals to 3."
  }
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