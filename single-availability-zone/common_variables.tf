###################################################################################################
###################################################################################################
#####                This Terraform file defines the variables used in All Modules           ######
#####                                      All Modules                                       ######
###################################################################################################
###################################################################################################

/**
 * Name: db_vsi_count
 * Type: number
 * Desc: Total Database instances that will be created in the user specified zone.
 *       We have kept the default value to be 2 here. The Database servers count cannot be more than 3.
 **/
variable "db_vsi_count" {
  description = "Total Database instances that will be created in the user specified zone."
  type        = number
  default     = 2
  validation {
    condition     = var.db_vsi_count <= 3
    error_message = "Database VSI count should be less than or equals to 3."
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
  default     = 80
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

/**
* Name: zone
* Type: String
* Description: Zone to be used for resources creation
*/
variable "zone" {
  description = "Please enter a zone to be used for resources creation"
  type        = string
}

/**
* Name: regions
* Type: map(any)
* Description: Region and zones mapping
**/
variable "regions" {
  description = "Region and Zones mapping"
  type        = map(any)
  default = {
    "us-south-1" = "us-south" #Dallas
    "us-south-2" = "us-south"
    "us-south-3" = "us-south"
    "us-east-1"  = "us-east" #Washington DC
    "us-east-2"  = "us-east"
    "us-east-3"  = "us-east"
    "eu-gb-1"    = "eu-gb" #London
    "eu-gb-2"    = "eu-gb"
    "eu-gb-3"    = "eu-gb"
    "eu-de-1"    = "eu-de" #Frankfurt
    "eu-de-2"    = "eu-de"
    "eu-de-3"    = "eu-de"
    "jp-tok-1"   = "jp-tok" #Tokyo
    "jp-tok-2"   = "jp-tok"
    "jp-tok-3"   = "jp-tok"
    "au-syd-1"   = "au-syd" #Sydney
    "au-syd-2"   = "au-syd"
    "au-syd-3"   = "au-syd"
    "jp-osa-1"   = "jp-osa" #Osaka
    "jp-osa-2"   = "jp-osa"
    "jp-osa-3"   = "jp-osa"
    "br-sao-1"   = "br-sao" #Sao Paulo
    "br-sao-2"   = "br-sao"
    "br-sao-3"   = "br-sao"
    "ca-tor-1"   = "ca-tor" #Toronto
    "ca-tor-2"   = "ca-tor"
    "ca-tor-3"   = "ca-tor"
  }
}

/**
* Name: api_key
* Type: String
* Description: Please enter the IBM Cloud API key
*/
variable "api_key" {
  description = "Please enter the IBM Cloud API key."
  type        = string
  sensitive   = true
}

/**
* Name: user_ssh_key
* Type: list
* Description: This is the list of the existing ssh key/keys of user which will be used to login to the Bastion server. For example "first-ssh-key,second-ssh-key". You can check your key name in IBM cloud.
*              If you don't have an existing key, then create one using <ssh-keygen -t rsa -b 4096 -C "user_ID"> command. And create a ssh key in IBM cloud with the public contents of file ~/.ssh/id_rsa.pub.
**/
variable "user_ssh_keys" {
  description = "This is the list of existing ssh key/keys on the User's machine and will be attached with the bastion server only.\nFor example: \"first-ssh-key,second-ssh-key\".\nThis will ensure the incoming connection on Bastion Server only from the users provided ssh_keys. You can check your key name in IBM cloud."
  type        = string
}

locals {
  user_ssh_key_list = [for x in split(",", var.user_ssh_keys) : trimspace(x)]
}


/**
* Name: resource_group_id
* Type: String
* Description: Resource Group ID to be used for resources creation
*/
variable "resource_group_id" {
  description = "Resource Group ID"
  type        = string
  validation {
    condition     = length(var.resource_group_id) == 32
    error_message = "Length of Resource Group ID should be 32 characters."
  }
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
    error_message = "For the prefix value only a-z, A-Z and 0-9 are allowed, the prefix should start with a character, and the prefix should end a with hyphen(-)."
  }
}
