/**
#################################################################################################################
*                           Variable Section for the Bastion Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group_id
* Type: String
* Description: Please enter the Resource Group ID to be used for creation of the resources
*/
variable "resource_group_id" {
  description = "Resource Group Name is used to seperate the resources in a group."
  type        = string
}

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
  * IP Count for the Bastion subnet
  * Value of bastion_ip_count will be from following 
  * 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192 and 16384
  * Please enter the IP count depending on the total_instance configuration
  */
variable "bastion_ip_count" {
  description = "IP count is the total number of total_ipv4_address_count for Bastion Subnet"
  type        = number
}

/**
* Name: public_ip_address_list
* Type: list
* Description: This is the list of User's Public IP address which will be used to login to Bastion VSI in the format X.X.X.X/32(for single ip address) or a valid CIDR.
**/
variable "public_ip_address_list" {
  description = "Provide the User's Public IP address in the format X.X.X.X/32 which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply"
  type        = list(any)
}

/**
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "Prefix for all the resources."
  type        = string
}

/**
* Name: vpc_id
* Type: String
* Description: This is the vpc id which will be used for bastion module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: user_ssh_key
* Type: String
* Description: This is the name of an existing ssh key of user which will be used to login to the Bastion server. You can check your key name in IBM cloud.
*              Whose private key content should be there in path ~/.ssh/id_rsa 
*              If you don't have an existing key, then create one using <ssh-keygen -t rsa -b 4096 -C "user_ID"> command. And create a ssh key in IBM cloud
*              with the public contents of file ~/.ssh/id_rsa.pub  **/
variable "user_ssh_key" {
  description = "This is the existing ssh key on the User's machine and will be attached with the bastion server only. This will ensure the incoming connection on Bastion Server only from the users provided ssh_keys"
  type        = list(any)
}

/**
* Name: bastion_ssh_key
* Type: String
* Description: This is the name of the ssh key which will be created dynamically on the bastion VSI. So that, users can login to Web/App/DB servers via Bastion server only.
*              If you are passing "bastion-ssh-key" name here, then the ssh key will create on IBM cloud dynamically with name "{var.prefix}-bastion-ssh-key".
*              As seen, this ssh key name will contain the prefix name as well.
**/
variable "bastion_ssh_key" {
  description = "This is the name of the ssh key which will be generated dynamically on the bastion server and further will be attached with all the other Web/App/DB servers. It will be used to login to Web/App/DB servers via Bastion server only."
  type        = string
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
* Name: bastion_profile
* Desc: This variable will hold the image profile name for bastion instance
* Type: String
**/
variable "bastion_profile" {
  description = "Specify the profile needed for Bastion VSI"
  type        = string
}

/**
* Name: zones
* Desc: List of Availability Zones where bastion resource will be created
* Type: String
**/
variable "zones" {
  description = "List of Availability Zones where bastion resource will be created"
  type        = list(any)
}

/**
* Name: bastion_os_type
* Desc: OS image to be used [windows | linux] for Bastion server
* Type: string
**/
variable "bastion_os_type" {
  description = "OS image to be used [windows | linux]"
  type        = string
}

/**
* Name: local_machine_os_type
* Desc: Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply
* Type: string
**/
variable "local_machine_os_type" {
  description = "Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply"
  type        = string
}

/**
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/
