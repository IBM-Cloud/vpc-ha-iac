/**
#################################################################################################################
*                                 Data Sources Output Variable Section
#################################################################################################################
**/


/**
* Output Variable
* Element : bastion1_key_id_op
* This variable will return the SSH key id created by Bastion-1 server.
**/
output "bastion1_key_id_op" {
  value       = data.ibm_is_ssh_key.bastion1_key_id.id
  description = "This variable will return the SSH key id created by Bastion-1 server"
}

/**
* Output Variable
* Element : bastion2_key_id_op
* This variable will return the SSH key id created by Bastion-1 server.
**/
output "bastion2_key_id_op" {
  value       = data.ibm_is_ssh_key.bastion2_key_id.id
  description = "This variable will return the SSH key id created by Bastion-2 server"
}