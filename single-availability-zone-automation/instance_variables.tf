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
  validation {
    condition     = length(var.db_image) == 41
    error_message = "Length of Custom image id for the Database VSI should be 41 characters."
  }
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
    condition     = contains(["3", "5", "10"], var.bandwidth)
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
  default     = "10"
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
* Name: db_name
* Type: string
* Description: Database will be created with the specified name
**/
variable "db_name" {
  description = "Database will be created with the specified name"
  type        = string
}


/**
* Name: db_user
* Type: string
* Description: Database user will be created with the specified name
**/
variable "db_user" {
  description = "Database user will be created with the specified name"
  type        = string
}



/**
* Name: db_pwd
* Type: string
* Description: Database user will be created with the specified password
**/
variable "db_pwd" {
  description = "Database user will be created with the specified password"
  type        = string
}

/**
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/

