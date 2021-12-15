/**
#################################################################################################################
*                                 Bastion Module Output Variable Section
#################################################################################################################
**/


/**
* Output Variable
* Element : Bastion IP
* Floating IP address for the Bastion VSI
* This variable will return array of IP address for the Bastion VSI
**/

output "bastion_ip" {
  value       = ibm_is_floating_ip.bastion_floating_ip.address
  description = "Bastion Server Floating IP Address"
  depends_on  = [ibm_is_instance.bastion, ibm_is_floating_ip.bastion_floating_ip]
}


/**
* Output Variable for Bastion Server Security Group
* This variable will return the Bastion Security Group ID 
**/
output "bastion_sg" {
  value       = ibm_is_security_group.bastion.id
  description = "Security Group id for the bastion"
}

/**
* Output Variable for Bastion Server CIDR
* This variable will return the Bastion Subnet CIDR range
**/
output "bastion_subnet_cidr" {
  value       = ibm_is_subnet.bastion_sub.ipv4_cidr_block
  description = "Subnet cidr of Bastion"
}

