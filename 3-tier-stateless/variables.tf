###################################################################################################
###################################################################################################

# This Terraform file defines the variables used in this Terraform scripts for this repo.
# Input variable allowing users to customizate aspects of the configuration when used directly 
# (e.g. via CLI, tfvars file or via environment variables), or as a module (via Module arguments)

##################################################################################################
##################################################################################################

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
* Name: zones
* Type: map(any)
* Description: Region and zones mapping
**/
variable "zones" {
  description = "Region and zones mapping"
  type        = map(any)
  default = {
    "us-south" = ["us-south-1", "us-south-2", "us-south-3"] #Dallas
    "us-east"  = ["us-east-1", "us-east-2", "us-east-3"]    #Washington DC
    "eu-gb"    = ["eu-gb-1", "eu-gb-2", "eu-gb-3"]          #London
    "eu-de"    = ["eu-de-1", "eu-de-2", "eu-de-3"]          #Frankfurt
    "jp-tok"   = ["jp-tok-1", "jp-tok-2", "jp-tok-3"]       #Tokyo
    "au-syd"   = ["au-syd-1", "au-syd-2", "au-syd-3"]       #Sydney
    "jp-osa"   = ["jp-osa-1", "jp-osa-2", "jp-osa-3"]       #Osaka
    "br-sao"   = ["br-sao-1", "br-sao-2", "br-sao-3"]       #Sao Paulo
    "ca-tor"   = ["ca-tor-1", "ca-tor-2", "ca-tor-3"]       #Toronto
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
  type        = string
  description = "Please enter the IBM Cloud API key."
  sensitive   = true
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
  type        = string
  description = "Enter your IBM cloud ssh key name."
}

/**
* Name: region
* Type: String
* Description: Please enter the IBM Cloud region to be used for creation of the resources
*/
variable "region" {
  description = "Please enter a region from the following available region and zones mapping: \nus-south\nus-east\neu-gb\neu-de\njp-tok\nau-syd"
  type        = string
}

/**
* Name: resource_group
* Type: String
* 
*/
variable "resource_group_id" {
  type        = string
  description = "Resource Group ID"
}

/**
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "This is the prefix text that will be prepended in every resource name created by this script."
  type        = string
  validation {
    condition     = length(var.prefix) <= 11
    error_message = "Length of prefix should be less than 11 characters."
  }
  validation {
    condition     = can(regex("^[A-Za-z][-0-9A-Za-z]*-$", var.prefix))
    error_message = "For the prefix value only a-z, A-Z and 0-9 are allowed, the prefix should start with a character, and the prefix should end with a hyphen(-)."
  }
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
* Name: bastion_image
* Desc: This variable will hold the image name for bastion instance. DO NOT change this image after the terraform apply is completed.
* Since bastion server should NOT be replaced or terminated once it got created.
* As this bastion server is very important to access other VSI. Bastion will hold the private key for the bastion-ssh-key pair attached to web/app/db servers.
* Type: String
**/
variable "bastion_image" {
  description = "Specify Image to be used with Bastion VSI"
  type        = string
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
* Name: web_image
* Desc: This variable will hold the image name for web instance
* Type: String
**/
variable "web_image" {
  description = " This variable will hold the image name for web instance"
  type        = string
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
* Name: db_image
* Desc: This variable will hold the image name for db instance
* Type: String
**/
variable "db_image" {
  description = "This variable will hold the image name for db instance"
  type        = string
}

/**
* Name: bastion_os_type
* Desc: OS image to be used [windows | linux] for Bastion server
* Type: string
**/
variable "bastion_os_type" {
  description = "OS image to be used [windows | linux] for Bastion server"
  type        = string
  validation {
    condition     = contains(["windows", "linux"], var.bastion_os_type)
    error_message = "Error: Incorrect value for Bastion OS Flavour. Allowed values are windows and linux."
  }
}

/**
  * IP Count for the Bastion subnet
  * Value of bastion_ip_count will be from following 
  * 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 and 16384
  * Please enter the IP count depending on the total_instance configuration
  */
variable "bastion_ip_count" {
  description = "IP count is the total number of total_ipv4_address_count for Bastion Subnet"
  type        = number
  default     = 8
  validation {
    condition     = contains([8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384], var.bastion_ip_count)
    error_message = "Error: Incorrect value for bastion_ip_count. Allowed values are 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384."
  }
}

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
* Name: local_machine_os_type
* Desc: Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply
* Type: string
**/
variable "local_machine_os_type" {
  description = "Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply"
  type        = string
  validation {
    condition     = contains(["windows", "mac", "linux"], var.local_machine_os_type)
    error_message = "Error: Incorrect value for Local Machine OS Flavour. Allowed values are windows, mac and linux."
  }
}

/**
* Name: my_public_ip
* Type: string
* Description: This is the User's Public IP address which will be used to login to Bastion VSI in the format X.X.X.X
*              Please update your public IP address everytime before executing terraform apply. As your Public IP address could be dynamically changing each day.
*              To get your Public IP you can use command <dig +short myip.opendns.com @resolver1.opendns.com> or visit "https://www.whatismyip.com"
**/
variable "my_public_ip" {
  description = "Provide the User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply"
  type        = string
  validation {
    condition     = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.my_public_ip))
    error_message = "Error: Invalid IP address provided."
  }
  validation {
    condition     = !can(regex("(^0\\.)|(^10\\.)|(^100\\.6[4-9]\\.)|(^100\\.[7-9][0-9]\\.)|(^100\\.1[0-1][0-9]\\.)|(^100\\.12[0-7]\\.)|(^127\\.)|(^169\\.254\\.)|(^172\\.1[6-9]\\.)|(^172\\.2[0-9]\\.)|(^172\\.3[0-1]\\.)|(^192\\.0\\.0\\.)|(^192\\.0\\.2\\.)|(^192\\.88\\.99\\.)|(^192\\.168\\.)|(^198\\.1[8-9]\\.)|(^198\\.51\\.100\\.)|(^203\\.0\\.113\\.)|(^22[4-9]\\.)|(^23[0-9]\\.)|(^24[0-9]\\.)|(^25[0-5]\\.)", var.my_public_ip))
    error_message = "Error: Please enter your own Public IP address in valid format."
  }
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
* Name: lb_protocol
* Type: map(any)
* Description: lbaas Protocols
**/
variable "lb_protocol" {
  description = "lbaaS protocols"
  type        = map(any)
  default = {
    "80"     = "http"
    "443"    = "https"
    "l4-tcp" = "tcp"
  }
}

/**
* Name: lb_algo
* Type: map(any)
* Description: lbaaS backend distribution algorithm
**/
variable "lb_algo" {
  description = "lbaaS backend distribution algorithm"
  type        = map(any)
  default = {
    "rr"      = "round_robin"
    "wrr"     = "weighted_round_robin"
    "least-x" = "least_connections"
  }
}

/**
* Name: lb_port_number
* Type: map(any)
* Description: Declare lbaaS pool member port number
**/
variable "lb_port_number" {
  description = "declare lbaaS pool member port numbert"
  type        = map(any)
  default = {
    "http"   = "80"
    "https"  = "443"
    "custom" = "xxx"
  }
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
