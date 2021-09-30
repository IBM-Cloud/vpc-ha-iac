/**
#################################################################################################################
*                           Variable Section for the SSH Key Data Sources Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Name: bastion1_key
* Type: String
* Desc: SSH key name created by the Bastion-1 server.
**/
variable "bastion1_key" {
  description = "SSH key name created by the Bastion-1 server"
  type        = string
}

/**
* Name: bastion2_key
* Type: String
* Desc: SSH key name created by the Bastion-2 server.
*/
variable "bastion2_key" {
  description = "SSH key name created by the Bastion-2 server"
  type        = string
}

/**               
#################################################################################################################
*                                   End of the Variable Section 
#################################################################################################################
**/