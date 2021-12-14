###################################################################################################
###################################################################################################
#####     This Terraform file defines the variables used in Security Group Module            ######
#####                                 Security Group Module                                  ######
###################################################################################################
###################################################################################################

/**
* Name: app_os_type
* Desc: OS image to be used Linux for App Server. This OS type should be same across both the regions.
* Type: string
**/
variable "app_os_type" {
  description = "OS image to be used Linux for App Server. This OS type should be same across both the regions."
  type        = string
  validation {
    condition     = contains(["linux"], var.app_os_type)
    error_message = "Error: Incorrect value for App OS Flavour. Currently support for linux OS only."
  }
}


/**
* Name: web_os_type
* Desc: OS image to be used linux for Web server. This OS type should be same across both the regions.
* Type: string
**/
variable "web_os_type" {
  description = "OS image to be used linux for Web server. This OS type should be same across both the regions."
  type        = string
  validation {
    condition     = contains(["linux"], var.web_os_type)
    error_message = "Error: Incorrect value for Web OS Flavour. Currently support for linux OS only."
  }
}


/**
* Name: db_os_type
* Desc: OS image to be used linux for DB server. This OS type should be same across both the regions.
* Type: string
**/
variable "db_os_type" {
  description = "OS image to be used linux for DB server. This OS type should be same across both the regions."
  type        = string
  validation {
    condition     = contains(["linux"], var.db_os_type)
    error_message = "Error: Incorrect value for DB OS Flavour. Currently support for linux OS only."
  }
}

