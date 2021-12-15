/**
#################################################################################################################
*                           Variable Section for the Instance Group Module.
*                                 Start Here for the Variable Section 
#################################################################################################################
*/

/**
* Name: prefix
* Type: String
* Desc: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "This is the prefix text that will be prepended in every resource name created by this Module"
  type        = string
}

/**
* Name: vpc_id
* Type: String
* Desc: This is the vpc id which will be used for instance group module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: resource_group_id
* Type: String
* Desc: Resource Group ID to be used for resources creation
*/
variable "resource_group_id" {
  description = "Resource Group ID is used to seperate the resources in a group."
  type        = string
}

/**
* Name: subnets
* Type: list
* Desc: Map of subnet objects
**/
variable "subnets" {
  description = "All subnet objects. This is required parameter"
  type = object({
    app = list(any)
    web = list(any)
  })
}

/**
* Name: Security Group
* Type: list
* Desc: Map of subnet objects
**/
variable "sg_objects" {
  description = "All Security Group objects. This is required parameter"
  type        = map(any)
}

/**
* Name: DB private IP
* Type: string
* Desc: This variable contains the value of DB private IP which is used for connection.
**/
variable "db_private_ip" {
  description = "This variable contains the value of DB private IP which is used for connection."
  type        = string
}

#################################################################################################################
##                                      Load Balancer Section                                                  ## 
#################################################################################################################
/**
* Name: A collection of LB objects
* Type: Object
* Desc: This variable will return the objects of LB, LB Pool and LB Listeners for app, db and web tiers.
**/
variable "objects" {
  description = "This variable will contains the objects of LB, LB Pool and LB Listeners. "
  type = object({
    lb       = map(any)
    pool     = map(any)
    listener = map(any)
  })
}



/**
* Name: ssh_key
* Type: list
* Desc: This is the ssh-key used to connect to the app/web/db VSI from Bastion VSI
**/
variable "ssh_key" {
  description = "This is the ssh-key used to connect to the app/web/db VSI from Bastion VSI"
  type        = list(any)
}

/**
* Name: zones
* Type: list(any)
* Desc: Region and zones mapping
**/
variable "zones" {
  description = "List of Availability Zones where compute resource will be created"
  type        = list(any)
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
}

/**
* Name: app_cooldown_time
* Type: number
* Desc: Specify the cool down period, 
*              the number of seconds to pause further scaling actions after scaling has taken place.
**/
variable "app_cooldown_time" {
  description = "Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place."
  type        = number
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
}

/**
* Name: web_cooldown_time
* Type: number
* Desc: Specify the cool down period, 
*              the number of seconds to pause further scaling actions after scaling has taken place.
**/
variable "web_cooldown_time" {
  description = "Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place."
  type        = number
}


/**
* Name: app_config
* Desc: application_port  : This is the Application port for App Servers. It could be same as the application load balancer listener port.           
*       max_servers_count : Maximum App servers count for the App Instance group
*       min_servers_count : Minimum App servers count for the App Instance group
*       cpu_percent       : Average target CPU Percent for CPU policy of App Instance Group
*       memory_percent    : Average target Memory Percent for Memory policy of App Instance Group
*       network_in        : Average target Network in (Mbps) for Network in policy of App Instance Group
*       network_out       : Average target Network out (Mbps) for Network out policy of App Instance Group"
*       instance_profile  : Hardware configuration profile for the App VSI.
* Type: map(any)
**/

variable "app_config" {
  description = "Application Configurations to be passed for App Instance Group creation"
  type        = map(any)
}


/**
* Name: app_image  
* Description: Image id for the App VSI for App Instance group template
* Type: string
**/

variable "app_image" {
  description = "Image id for the App VSI for App Instance group template"
  type        = string
}

/**
* Name: app_max_servers_count
* Type: number
* Desc: Maximum number of VSI count for the App Instance group.
*       The minimum and maximum instance is the total of all instances 
*       (of current plus auto scaled instances). 
*       The maximum is the upper limit of total number of VSI in that Instance Group. 
*       Also, when you are choosing the maximum number, make sure that the subnet has 
*       enough spare IP addresses to accommodate any new provisioned virtual server instances 
*       that are created by the Auto scale feature.
**/
variable "app_max_servers_count" {
  description = "Maximum App servers count for the App Instance group"
  type        = number
}

/**
* Name: app_min_servers_count
* Type: number
* Desc: Minimum number of VSI count for the App Instance group.
*       The minimum and maximum instance is the total of all instances 
*       (of current plus auto scaled instances). 
*       The minimum ensures that there will be always these many resources available regardless of CPU policy.
*       Also, when you are choosing the maximum number, make sure that the subnet has 
*       enough spare IP addresses to accommodate any new provisioned virtual server instances 
*       that are created by the Auto scale feature.
**/
variable "app_min_servers_count" {
  description = "Minimum App servers count for the App Instance group"
  type        = number
}

/**
* Name: app_cpu_threshold
* Type: number
* Desc: Average target CPU Percent for CPU policy of App Instance Group.
**/
variable "app_cpu_threshold" {
  description = "Average target CPU Percent for CPU policy of App Instance Group"
  type        = number
}

/**
* Name: web_config
* Desc: application_port  : This is the Application port for Web Servers. It could be same as the application load balancer listener port.           
*       max_servers_count : Maximum Web servers count for the Web Instance group
*       min_servers_count : Minimum Web servers count for the Web Instance group
*       cpu_percent       : Average target CPU Percent for CPU policy of Web Instance Group
*       memory_percent    : Average target Memory Percent for Memory policy of Web Instance Group
*       network_in        : Average target Network in (Mbps) for Network in policy of Web Instance Group
*       network_out       : Average target Network out (Mbps) for Network out policy of Web Instance Group"
*       instance_image    : Image id for the Web VSI for Web Instance group template
*       instance_profile  : Hardware configuration profile for the Web VSI.
* Type: map(any)
**/

variable "web_config" {
  description = "Web Configurations to be passed for Web Instance Group creation"
  type        = map(any)
}

/**
* Name: web_image  
* Description: Image id for the Web VSI for Web Instance group template
* Type: string
**/

variable "web_image" {
  description = "Image id for the Web VSI for Web Instance group template"
  type        = string
}


/**
* Name: web_max_servers_count
* Type: number
* Desc: Maximum Web servers count for the Web Instance group
**/
variable "web_max_servers_count" {
  description = "Maximum Web servers count for the Web Instance group"
  type        = number
}

/**
* Name: web_min_servers_count
* Type: number
* Desc: Minimum Web servers count for the Web Instance group
**/
variable "web_min_servers_count" {
  description = "Minimum Web servers count for the Web Instance group"
  type        = number
}

/**
* Name: web_cpu_threshold
* Type: number
* Desc: Average target CPU Percent for CPU policy of Web Instance Group.
**/
variable "web_cpu_threshold" {
  description = "Average target CPU Percent for CPU policy of Web Instance Group"
  type        = number
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
