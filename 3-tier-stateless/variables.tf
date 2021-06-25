###################################################################################################
###################################################################################################

# This Terraform file defines the variables used in this Terraform scripts for this repo.
# Input variable allowing users to customize aspects of the configuration when used directly 
# (e.g. via CLI, tfvars file or via environment variables), or as a module (via Module arguments)

##################################################################################################
##################################################################################################


variable "ssh_key" {
  type        = string
  description = "Enter your IBM cloud ssh key name."
}

variable "total_instance" {
  default     = 1
  type        = number
  description = "Total instances that will be created per zones per tier."
}
/**
  * IP Count for the subnet
  * Value of ip_count will be from following 
  * 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 and 16384
  * Please enter the IP count depending on the total_instance configuration
  */
variable "ip_count" {
  description = "Enter total number of IP Address for each subnet"
  type        = any
  default     = 32
}

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


##################################################################################################
############################## User Input Variables Section ####################################
##################################################################################################

variable "api_key" {
  type        = string
  description = "Please enter the IBM Cloud API key."
}

variable "region" {
  description = "Please enter a region from the following available region and zones mapping: \nus-south\nus-east\neu-gb\neu-de\njp-tok\nau-syd"
  type        = string
}

/**
* Name: resource_group
* Type: String
* 
*/
variable "resource_group" {
  type        = string
  description = "Resource Group:"
}

/**
*
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
*
**/
variable "prefix" {
  type        = string
  description = "This is the prefix text that will be prepended in every resource name created by this script."
}


