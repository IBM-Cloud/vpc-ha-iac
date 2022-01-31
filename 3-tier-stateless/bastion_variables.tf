###################################################################################################
###################################################################################################
#####           This Terraform file defines the variables used in Bastion Modules            ######
#####                                 Bastion Modules                                        ######
###################################################################################################
###################################################################################################

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
