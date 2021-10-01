###################################################################################################
###################################################################################################
#####     This Terraform file defines the variables used in Security Group Module            ######
#####                                 Security Group Module                                  ######
###################################################################################################
###################################################################################################

/**
* Name: app_os_type
* Desc: OS image to be used [Windows | Linux] for App Server. This OS type should be same across both the regions.
* Type: string
**/
variable "app_os_type" {
  description = "OS image to be used [Windows | Linux] for App Server. This OS type should be same across both the regions. If OS flavor is Windows then we will try to install IIS and OpenSSH service and Rebooting the server .So, It will take minimum 5-10 mins to make the Server avilable."
  type        = string

  validation {
    condition     = contains(["Windows", "windows", "Linux", "linux"], var.app_os_type)
    error_message = "Error: Incorrect value for App OS Flavour. Allowed values are Windows, windows, Linux and linux."
  }
}


/**
* Name: web_os_type
* Desc: OS image to be used [Windows | Linux] for Web server. This OS type should be same across both the regions.
* Type: string
**/
variable "web_os_type" {
  description = "OS image to be used [Windows | Linux] for Web server. This OS type should be same across both the regions. If OS flavor is Windows then we will try to install IIS and OpenSSH service and Rebooting the server .So, It will take minimum 5-10 mins to make the Server avilable."
  type        = string

  validation {
    condition     = contains(["Windows", "windows", "Linux", "linux"], var.web_os_type)
    error_message = "Error: Incorrect value for Web OS Flavour. Allowed values are Windows, windows, Linux and linux."
  }
}


/**
* Name: db_os_type
* Desc: OS image to be used [Windows | Linux] for DB server. This OS type should be same across both the regions.
* Type: string
**/
variable "db_os_type" {
  description = "OS image to be used [Windows | Linux] for DB server. This OS type should be same across both the regions. If OS flavor is Windows then we will try to install IIS and OpenSSH service and Rebooting the server .So, It will take minimum 5-10 mins to make the Server avilable."
  type        = string

  validation {
    condition     = contains(["Windows", "windows", "Linux", "linux"], var.db_os_type)
    error_message = "Error: Incorrect value for DB OS Flavour. Allowed values are Windows, windows, Linux and linux."
  }
}

