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
* Name: db_image
* Desc: This variable will hold the image name for db instance
* Type: String
**/
variable "db_image" {
  description = "This variable will hold the image name for db instance"
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
  default     = "cx2-2x4"
}

/**
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/