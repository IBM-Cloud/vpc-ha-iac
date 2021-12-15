/**
#################################################################################################################
*                                 Bastion Module Output Variable Section
#################################################################################################################
**/

/**
* Output Variable for Bastion Server Security Group
* This variable will return the Bastion Security Group ID 
**/
output "bastion_sg" {
  value       = ibm_is_security_group.bastion.id
  description = "Security Group id for the bastion"
}

/**
* Output Variable for Bastion Server Subnet Details
* This variable will return the Subnet details of Bastion server
**/
output "bastion_subnet" {
  value       = ibm_is_subnet.bastion_sub
  description = "Subnet details for the bastion server"
}
