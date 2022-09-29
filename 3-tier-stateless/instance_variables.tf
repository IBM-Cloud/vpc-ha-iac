###################################################################################################
###################################################################################################
#####           This Terraform file defines the variables used in Instance Module            ######
#####                                       Instance Module                                  ######
###################################################################################################
###################################################################################################

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
* Name: web_profile
* Desc: This variable will hold the image profile name for web instance
* Type: String
**/
variable "web_profile" {
  description = "This variable will hold the image profile name for web instance"
  type        = string
  default     = "cx2-2x4"
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
* Name: app_profile
* Desc: This variable will hold the image profile name for app instance
* Type: String
**/
variable "app_profile" {
  description = "This variable will hold the image profile name for app instance"
  type        = string
  default     = "cx2-2x4"
}

/**
* Name: db_vsi_count
* Type: number
* Desc: Total Database instances that will be created in the user specified region.
**/
variable "db_vsi_count" {
  description = "Total Database instances that will be created in the user specified region."
  type        = number
  default     = 2
}

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
* Name: db_profile
* Desc: This variable will hold the image profile name for db instance
* Type: String
**/
variable "db_profile" {
  description = "This variable will hold the image profile name for db instance"
  type        = string
  default     = "cx2-2x4"
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
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/