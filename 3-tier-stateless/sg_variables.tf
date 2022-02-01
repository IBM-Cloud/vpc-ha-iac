
###################################################################################################
###################################################################################################
#####     This Terraform file defines the variables used in Security Group Module            ######
#####                                 Security Group Module                                  ######
###################################################################################################
###################################################################################################


/**
* Name: app_os_type
* Desc: OS image to be used [windows | linux] for App Server
* Type: string
**/
variable "app_os_type" {
  description = "OS image to be used [windows | linux] for App Server"
  type        = string
  validation {
    condition     = contains(["windows", "linux"], var.app_os_type)
    error_message = "Error: Incorrect value for App OS Flavour. Allowed values are windows and linux."
  }
}

/**
* Name: web_os_type
* Desc: OS image to be used [windows | linux] for Web Server
* Type: string
**/
variable "web_os_type" {
  description = "OS image to be used [windows | linux] for Web Server"
  type        = string
  validation {
    condition     = contains(["windows", "linux"], var.web_os_type)
    error_message = "Error: Incorrect value for Web OS Flavour. Allowed values are windows and linux."
  }
}

/**
* Name: db_os_type
* Desc: OS image to be used [windows | linux] for DB Server
* Type: string
**/
variable "db_os_type" {
  description = "OS image to be used [windows | linux] for DB Server"
  type        = string
  validation {
    condition     = contains(["windows", "linux"], var.db_os_type)
    error_message = "Error: Incorrect value for DB OS Flavour. Allowed values are windows and linux."
  }
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
