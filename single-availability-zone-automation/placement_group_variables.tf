###################################################################################################
###################################################################################################
#####         This Terraform file defines the variables used in Placement group module       ######
#####                                     Placement group module                             ######
###################################################################################################
###################################################################################################

/**
* Name: db_pg_strategy
* Type: string
* Desc: The strategy for Database servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
**/

variable "db_pg_strategy" {
  description = "The strategy for Database servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources."
  type        = string
  validation {
    condition     = contains(["host_spread", "power_spread"], var.db_pg_strategy)
    error_message = "Error: Incorrect value for DB Placement group Strategy. Allowed values are host_spread and power_spread."
  }
}

/**
* Name: web_pg_strategy
* Type: string
* Desc: The strategy for Web servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
**/

variable "web_pg_strategy" {
  description = "The strategy for Web servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources."
  type        = string
  validation {
    condition     = contains(["host_spread", "power_spread"], var.web_pg_strategy)
    error_message = "Error: Incorrect value for Web Placement group Strategy. Allowed values are host_spread and power_spread."
  }
}

/**
* Name: app_pg_strategy
* Type: string
* Desc: The strategy for App servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
**/

variable "app_pg_strategy" {
  description = "The strategy for App servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources."
  type        = string
  validation {
    condition     = contains(["host_spread", "power_spread"], var.app_pg_strategy)
    error_message = "Error: Incorrect value for App Placement group Strategy. Allowed values are host_spread and power_spread."
  }
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
