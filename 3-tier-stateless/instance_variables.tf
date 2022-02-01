###################################################################################################
###################################################################################################
#####           This Terraform file defines the variables used in Instance Module            ######
#####                                       Instance Module                                  ######
###################################################################################################
###################################################################################################

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