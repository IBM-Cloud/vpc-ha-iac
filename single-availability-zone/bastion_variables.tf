###################################################################################################
###################################################################################################
#####           This Terraform file defines the variables used in Bastion Modules            ######
#####                                 Bastion Modules                                        ######
###################################################################################################
###################################################################################################

/**
* Name: enable_floating_ip
* Type: bool
* Description: Determines whether to enable floating IP for Bastion server or not. Give true or false.
**/
variable "enable_floating_ip" {
  description = "Determines whether to enable floating IP for Bastion server or not. Give true or false."
  type        = bool
}

/**
* Name: bastion_image
* Type: String
* Description: This is the image id used for Bastion VSI.
**/
variable "bastion_image" {
  description = "Custom image id for the Bastion VSI"
  type        = string
  validation {
    condition     = length(var.bastion_image) == 41
    error_message = "Length of Custom image id for the Bastion VSI should be 41 characters."
  }
}

/**
* Name: public_ip_address_list
* Type: list
* Description: This is the list of User's Public IP address which will be used to login to Bastion VSI in the format X.X.X.X
*              Please update your public IP address every time before executing terraform apply. As your Public IP address could be dynamically changing each day.
*              To get your Public IP you can use command <dig +short myip.opendns.com @resolver1.opendns.com> or visit "https://www.whatismyip.com"
**/
variable "public_ip_addresses" {
  description = "Provide the list of User's Public IP addresses in the format \"X.X.X.X\" which will be used to login to Bastion VSI.\nFor example: \"123.201.8.30,219.91.139.49\". \nAlso Please provide the updated list of public IP addresses everytime before executing."
  type        = string
  validation {
    condition     = can([for y in formatlist("%s/32", [for x in split(",", var.public_ip_addresses) : trimspace(x)]) : regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(/((?:[1-9])|(?:[1-2][0-9])|(?:3[0-2])))$", y)])
    error_message = "Error: Format of the provided IP addresses in the list is not valid."
  }
  validation {
    condition     = alltrue([for x in formatlist("%s/32", [for x in split(",", var.public_ip_addresses) : trimspace(x)]) : !can(regex("(^0\\.)|(^10\\.)|(^100\\.6[4-9]\\.)|(^100\\.[7-9][0-9]\\.)|(^100\\.1[0-1][0-9]\\.)|(^100\\.12[0-7]\\.)|(^127\\.)|(^169\\.254\\.)|(^172\\.1[6-9]\\.)|(^172\\.2[0-9]\\.)|(^172\\.3[0-1]\\.)|(^192\\.0\\.0\\.)|(^192\\.0\\.2\\.)|(^192\\.88\\.99\\.)|(^192\\.168\\.)|(^198\\.1[8-9]\\.)|(^198\\.51\\.100\\.)|(^203\\.0\\.113\\.)|(^22[4-9]\\.)|(^23[0-9]\\.)|(^24[0-9]\\.)|(^25[0-5]\\.)", x))])
    error_message = "Error: Provided IP address in the list is not a public IP address."
  }
}
locals {
  public_ip_address_list = formatlist("%s/32", [for x in split(",", var.public_ip_addresses) : trimspace(x)])
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
* Name: bastion_os_type
* Desc: OS image to be used linux for Bastion server
* Type: string
**/
variable "bastion_os_type" {
  description = "OS image to be used linux for Bastion server"
  type        = string
  validation {
    condition     = contains(["linux"], var.bastion_os_type)
    error_message = "Error: Incorrect value for Bastion OS Flavour. Currently support for linux OS only."
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
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/


