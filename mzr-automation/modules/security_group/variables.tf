/**
#################################################################################################################
*                           Variable Section for the Security Group Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group_id
* Type: String
*/
variable "resource_group_id" {
  description = "Resource Group Name is used to seperate the resources in a group."
  type        = string
}

/**
* Name: bastion_sg
* Type: String
*/
variable "bastion_sg" {
  description = "Bastion Security Group ID"
  type        = string
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
* Name: alb_port
* Type: number
* Description: This is the Application load balancer listener port
**/
variable "alb_port" {
  description = "This is the Application load balancer listener port"
  type        = number
}

/**
* Name: vpc_id
* Type: String
* Description: This is the vpc id which will be used for security group module. We are passing this vpc_id from main.tf
**/
variable "vpc_id" {
  description = "Required parameter vpc_id"
  type        = string
}

/**
* Name: my_public_ip
* Type: string
* Description: This is the User's Public IP address which will be used to login to Bastion VSI in the format X.X.X.X
**/
variable "my_public_ip" {
  description = "Provide the User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply"
  type        = string
}

/**
* Name: app_os_type
* Desc: OS image to be used [windows | linux] for App Server
* Type: string
**/
variable "app_os_type" {
  description = "OS image to be used [windows | linux] for App Server"
  type        = string
}

/**
* Name: web_os_type
* Desc: OS image to be used [windows | linux] for Web Server
* Type: string
**/
variable "web_os_type" {
  description = "OS image to be used [windows | linux] for Web Server"
  type        = string
}

/**
* Name: db_os_type
* Desc: OS image to be used [windows | linux] for Db Server
* Type: string
**/
variable "db_os_type" {
  description = "OS image to be used [windows | linux] for DB Server"
  type        = string
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/
