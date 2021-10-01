###################################################################################################
###################################################################################################
#####        This Terraform file defines the variables used in Instance Group Module         ######
#####                                    Instance Group Module                               ######
###################################################################################################
###################################################################################################

/**
* Name: web_config
* Desc: This web_config map will be passed to the Instance Group Module
*       application_port  : This is the Application port for Web Servers. It could be same as the application load balancer listener port.         
*       memory_percent    : Average target Memory Percent for Memory policy of Web Instance Group
*       network_in        : Average target Network in (Mbps) for Network in policy of Web Instance Group
*       network_out       : Average target Network out (Mbps) for Network out policy of Web Instance Group"
*       instance_profile  : Hardware configuration profile for the Web VSI.
* Type: map(any)
**/

variable "web_config" {
  description = "Web Configurations to be passed for Web Instance Group creation"
  type        = map(any)
  default = {
    "application_port" = "80"
    "memory_percent"   = "40"
    "network_in"       = "40"
    "network_out"      = "40"
    "instance_profile" = "cx2-2x4"
  }
}

/**
 * Name: web_image_region1
 * Type: String
 * Description: This is the image id used for web VSI.
 **/
variable "web_image_region1" {
  description = "Custom image id for the web VSI from Region-1"
  type        = string
}

/**
 * Name: web_image_region2
 * Type: String
 * Description: This is the image id used for web VSI.
 **/
variable "web_image_region2" {
  description = "Custom image id for the web VSI from Region-2"
  type        = string
}


/**
* Name: web_max_servers_count
* Type: number
* Description: Maximum Web servers count for the Web Instance group
**/
variable "web_max_servers_count" {
  description = "Maximum Web servers count for the Web Instance group"
  type        = number
  validation {
    condition     = var.web_max_servers_count >= 1 && var.web_max_servers_count <= 1000
    error_message = "Error: Incorrect value for web_max_servers_count. Allowed value should be between 1 and 1000."
  }
}

/**
* Name: web_min_servers_count
* Type: number
* Description: Minimum Web servers count for the Web Instance group
**/
variable "web_min_servers_count" {
  description = "Minimum Web servers count for the Web Instance group"
  type        = number
  validation {
    condition     = var.web_min_servers_count >= 1 && var.web_min_servers_count <= 1000
    error_message = "Error: Incorrect value for web_min_servers_count. Allowed value should be between 1 and 1000."
  }
}

/**
* Name: web_cpu_threshold
* Type: number
* Description: Average target CPU Percent for CPU policy of Web Instance Group.
**/
variable "web_cpu_threshold" {
  description = "Average target CPU Percent for CPU policy of Web Instance Group"
  type        = number
  validation {
    condition     = var.web_cpu_threshold >= 10 && var.web_cpu_threshold <= 90
    error_message = "Error: Incorrect value for web_cpu_threshold. Allowed value should be between 10 and 90."
  }
}

/**
* Name: web_aggregation_window
* Type: number
* Desc: Specify the aggregation window. 
*       The aggregation window is the time period in seconds 
*       that the instance group manager monitors each instance and determines the average utilization.
**/
variable "web_aggregation_window" {
  description = "The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization."
  type        = number
  default     = 90
  validation {
    condition     = var.web_aggregation_window >= 90 && var.web_aggregation_window <= 600
    error_message = "Error: Incorrect value for web_aggregation_window. Allowed value should be between 90 and 600."
  }
}

/**
* Name: web_cooldown_time
* Type: number
* Desc: Specify the cool down period, 
*       the number of seconds to pause further scaling actions after scaling has taken place.
**/
variable "web_cooldown_time" {
  description = "Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place."
  type        = number
  default     = 120
  validation {
    condition     = var.web_cooldown_time >= 120 && var.web_cooldown_time <= 3600
    error_message = "Error: Incorrect value for web_cooldown_time. Allowed value should be between 120 and 3600."
  }
}



##############################################################################################################
##############################################################################################################
################                         APP Instance Group Variables                        #################
##############################################################################################################
##############################################################################################################

/**
* Name: app_config
* Desc: This app_config map will be passed to the Instance Group Module
*       application_port  : This is the Application port for App Servers. It could be same as the application load balancer listener port.
*       memory_percent    : Average target Memory Percent for Memory policy of App Instance Group
*       network_in        : Average target Network in (Mbps) for Network in policy of App Instance Group
*       network_out       : Average target Network out (Mbps) for Network out policy of App Instance Group"
*       instance_profile  : Hardware configuration profile for the App VSI.
* Type: map(any)
**/

variable "app_config" {
  description = "Application Configurations to be passed for App Instance Group creation"
  type        = map(any)
  default = {
    "application_port" = "80"
    "memory_percent"   = "40"
    "network_in"       = "40"
    "network_out"      = "40"
    "instance_profile" = "cx2-2x4"
  }
}

/**
 * Name: app_image_region1
 * Type: String
 * Description: This is the image id used for app VSI from Region-1.
 **/
variable "app_image_region1" {
  description = "Custom image id for the app VSI"
  type        = string
}

/**
 * Name: app_image_region2
 * Type: String
 * Description: This is the image id used for app VSI from Region-2.
 **/
variable "app_image_region2" {
  description = "Custom image id for the app VSI"
  type        = string
}

/**
* Name: app_max_servers_count
* Type: number
* Description: Maximum App servers count for the App Instance group
**/
variable "app_max_servers_count" {
  description = "Maximum App servers count for the App Instance group"
  type        = number
  validation {
    condition     = var.app_max_servers_count >= 1 && var.app_max_servers_count <= 1000
    error_message = "Error: Incorrect value for app_max_servers_count. Allowed value should be between 1 and 1000."
  }
}

/**
* Name: app_min_servers_count
* Type: number
* Description: Minimum App servers count for the App Instance group
**/
variable "app_min_servers_count" {
  description = "Minimum App servers count for the App Instance group"
  type        = number
  validation {
    condition     = var.app_min_servers_count >= 1 && var.app_min_servers_count <= 1000
    error_message = "Error: Incorrect value for app_min_servers_count. Allowed value should be between 1 and 1000."
  }
}

/**
* Name: app_cpu_threshold
* Type: number
* Description: Average target CPU Percent for CPU policy of App Instance Group.
**/
variable "app_cpu_threshold" {
  description = "Average target CPU Percent for CPU policy of App Instance Group"
  type        = number
  validation {
    condition     = var.app_cpu_threshold >= 10 && var.app_cpu_threshold <= 90
    error_message = "Error: Incorrect value for app_cpu_threshold. Allowed value should be between 10 and 90."
  }
}

/**
* Name: app_aggregation_window
* Type: number
* Desc: Specify the aggregation window. 
*       The aggregation window is the time period in seconds 
*       that the instance group manager monitors each instance and determines the average utilization.
**/
variable "app_aggregation_window" {
  description = "The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization."
  type        = number
  default     = 90
  validation {
    condition     = var.app_aggregation_window >= 90 && var.app_aggregation_window <= 600
    error_message = "Error: Incorrect value for app_aggregation_window. Allowed value should be between 90 and 600."
  }
}

/**
* Name: app_cooldown_time
* Type: number
* Desc: Specify the cool down period, 
*       the number of seconds to pause further scaling actions after scaling has taken place.
**/
variable "app_cooldown_time" {
  description = "Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place."
  type        = number
  default     = 120
  validation {
    condition     = var.app_cooldown_time >= 120 && var.app_cooldown_time <= 3600
    error_message = "Error: Incorrect value for app_cooldown_time. Allowed value should be between 120 and 3600."
  }
}

