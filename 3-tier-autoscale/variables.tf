###################################################################################################
###################################################################################################

# This Terraform file defines the variables used in this Terraform scripts for this repo.
# Input variable allowing users to customize aspects of the configuration when used directly 
# (e.g. via CLI, tfvars file or via environment variables), or as a module (via module arguments)

##################################################################################################
##################################################################################################

/**
* Name: app_config
* Desc: This app_config map will be passed to the Instance Group Module
*       application_port  : This is the Application port for App Servers. It could be same as the application load balancer listener port.     
*       max_servers_count : Maximum App servers count for the App Instance group
*       min_servers_count : Minimum App servers count for the App Instance group
*       cpu_percent       : Average target CPU Percent for CPU policy of App Instance Group
*       memory_percent    : Average target Memory Percent for Memory policy of App Instance Group
*       network_in        : Average target Network in (Mbps) for Network in policy of App Instance Group
*       network_out       : Average target Network out (Mbps) for Network out policy of App Instance Group"
*       instance_image    : Image id for the App VSI for App Instance group template
*       instance_profile  : Hardware configuration profile for the App VSI.
* Type: map(number)
**/


variable "app_config" {
  description = "Application Configurations to be passed for App Instance Group creation"
  type        = map(any)
  default = {
    "application_port" = "80"
    "memory_percent"   = "40"
    "network_in"       = "40"
    "network_out"      = "40"
    "instance_image"   = "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"
    "instance_profile" = "cx2-2x4"
  }
}

/**
* Name: app_max_servers_count
* Type: number
* Description: Maximum App servers count for the App Instance group
**/
variable "app_max_servers_count" {
  description = "Maximum App servers count for the App Instance group"
  type        = number
}

/**
* Name: app_min_servers_count
* Type: number
* Description: Minimum App servers count for the App Instance group
**/
variable "app_min_servers_count" {
  description = "Minimum App servers count for the App Instance group"
  type        = number
}

/**
* Name: app_cpu_percent
* Type: number
* Description: Average target CPU Percent for CPU policy of App Instance Group.
**/
variable "app_cpu_percent" {
  description = "Average target CPU Percent for CPU policy of App Instance Group"
  type        = number
}

/**
* Name: web_config
* Desc: This web_config map will be passed to the Instance Group Module
*       application_port  : This is the Application port for Web Servers. It could be same as the application load balancer listener port.         
*       memory_percent    : Average target Memory Percent for Memory policy of Web Instance Group
*       network_in        : Average target Network in (Mbps) for Network in policy of Web Instance Group
*       network_out       : Average target Network out (Mbps) for Network out policy of Web Instance Group"
*       instance_image    : Image id for the Web VSI for Web Instance group template
*       instance_profile  : Hardware configuration profile for the Web VSI.
* Type: map(number)
**/

variable "web_config" {
  description = "Web Configurations to be passed for Web Instance Group creation"
  type        = map(any)
  default = {
    "application_port" = "80"
    "memory_percent"   = "40"
    "network_in"       = "40"
    "network_out"      = "40"
    "instance_image"   = "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"
    "instance_profile" = "cx2-2x4"
  }
}

/**
* Name: web_max_servers_count
* Type: number
* Description: Maximum Web servers count for the Web Instance group
**/
variable "web_max_servers_count" {
  description = "Maximum Web servers count for the Web Instance group"
  type        = number
}

/**
* Name: web_min_servers_count
* Type: number
* Description: Minimum Web servers count for the Web Instance group
**/
variable "web_min_servers_count" {
  description = "Minimum Web servers count for the Web Instance group"
  type        = number
}

/**
* Name: web_cpu_percent
* Type: number
* Description: Average target CPU Percent for CPU policy of Web Instance Group.
**/
variable "web_cpu_percent" {
  description = "Average target CPU Percent for CPU policy of Web Instance Group"
  type        = number
}

/**
* Name: bastion_ssh_key_var_name
* Type: String
* Description: This is the name of the ssh key which will be created dynamically on the bastion VSI. So that, users can login to Web/App/DB servers via Bastion server only.
*              If you are passing "bastion-ssh-key" name here, then the ssh key will create on IBM cloud dynamically with name "{var.prefix}-bastion-ssh-key".
*              As seen, this ssh key name will contain the prefix name as well.
**/
variable "bastion_ssh_key_var_name" {
  description = "This is the name of the ssh key which will be generated dynamically on the bastion server and further will be attached with all the other Web/App/DB servers. It will be used to login to Web/App/DB servers via Bastion server only."
  type        = string
  default     = "bastion-ssh-key"
}

/**
* Name: db_image
* Type: String
* Description: This is the image id used for DB VSI.
**/
variable "db_image" {
  description = "Custom image id for the Database VSI"
  type        = string
  default     = "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"
}

/**
* Name: bastion_profile
* Type: String
* Description: Specify the profile needed for Bastion VSI.
**/
variable "bastion_profile" {
  description = "Specify the profile needed for Bastion VSI"
  type        = string
  default     = "cx2-2x4"
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
* Name: alb_port
* Type: number
* Description: This is the Application load balancer listener port
**/
variable "alb_port" {
  description = "This is the Application load balancer listener port"
  type        = number
  default     = "80"
}

/**
* Name: dlb_port
* Type: number
* Description: This is the DB load balancer listener port
**/
variable "dlb_port" {
  description = "This is the DB load balancer listener port"
  type        = number
  default     = "80"
}

/**
* Name: total_instance
* Type: number
* Description: Total instances that will be created per zones per tier.
**/
variable "total_instance" {
  description = "Total instances that will be created per zones per tier."
  type        = number
  default     = 1

}

/**
  * IP Count for the subnet
  * Value of ip_count will be from following 
  * 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 and 16384
  * Please enter the IP count depending on the total_instance configuration
  */
variable "ip_count" {
  description = "Enter total number of IP Address for each subnet"
  type        = number
  default     = 32
}

/**
* Name: zones
* Type: map(any)
* Description: Region and zones mapping
**/
variable "zones" {
  description = "Region and zones mapping"
  type        = map(any)
  default = {
    "us-south" = ["us-south-1", "us-south-2", "us-south-3"]
    "us-east"  = ["us-east-1", "us-east-2", "us-east-3"]
    "eu-gb"    = ["eu-gb-1", "eu-gb-2", "eu-gb-3"]
    "eu-de"    = ["eu-de-1", "eu-de-2", "eu-de-3"]
    "jp-tok"   = ["jp-tok-1", "jp-tok-2", "jp-tok-3"]
    "au-syd"   = ["au-syd-1", "au-syd-2", "au-syd-3"]
  }
}

/**
* Name: size
* Desc: Volume Storage size in GB. It will be used for the extra storage volume attached with the DB servers.
* Type: number
**/
variable "size" {
  description = "Storage size in GB. The value should be between 10 and 2000"
  type        = number
  default     = "10"
  validation {
    condition     = var.size >= 10 && var.size <= 2000
    error_message = "Error: Incorrect value for size. Allowed size should be between 10 and 2000 GB."
  }
}

##################################################################################################
############################## User Input Variables Section ####################################
##################################################################################################

/**
* Name: api_key
* Type: String
* Description: Please enter the IBM Cloud API key
*/
variable "api_key" {
  description = "Please enter the IBM Cloud API key."
  type        = string
}

/**
* Name: region
* Type: String
* Description: Region to be used for resources creation
*/
variable "region" {
  description = "Please enter a region from the following available region and zones mapping: \nus-south\nus-east\neu-gb\neu-de\njp-tok\nau-syd"
  type        = string
}

/**
* Name: user_ssh_key
* Type: String
* Description: This is the name of an existing ssh key of user which will be used to login to the Bastion server. You can check your key name in IBM cloud.
*              Whose private key content should be there in path ~/.ssh/id_rsa 
*              If you don't have an existing key, then create one using <ssh-keygen -t rsa -b 4096 -C "user_ID"> command. And create a ssh key in IBM cloud
*              with the public contents of file ~/.ssh/id_rsa.pub  
**/
variable "user_ssh_key" {
  description = "This is the existing ssh key on the User's machine and will be attached with the bastion server only. This will ensure the incoming connection on Bastion Server only from the users provided ssh_keys. You can check your key name in IBM cloud. Whose private key content should be there in path ~/.ssh/id_rsa"
  type        = string
}

/**
* Name: user_ip_address
* Type: string
* Description: This is the User's Public IP address which will be used to login to Bastion VSI in the format X.X.X.X
*              Please update your public IP address everytime before executing terraform apply. As your Public IP address could be dynamically changing each day.
*              To get your Public IP you can use command <dig +short myip.opendns.com @resolver1.opendns.com> or visit "https://www.whatismyip.com"
**/
variable "user_ip_address" {
  description = "Provide the User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply"
  type        = string
  validation {
    condition     = var.user_ip_address != "192.168.1.1"
    error_message = "Error: Please enter your own Public IP address in valid format."
  }
}

/**
* Name: resource_group_id
* Type: String
* Description: Resource Group ID to be used for resources creation
*/
variable "resource_group_id" {
  description = "Resource Group ID"
  type        = string
}

/**
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "This is the prefix text that will be prepended in every resource name created by this script."
  type        = string
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


