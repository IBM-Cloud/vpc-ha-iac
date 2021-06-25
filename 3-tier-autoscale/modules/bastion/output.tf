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
* Output Variable
* Element : SSH-Key
* This ssh-key will be used while creating app/web/db servers. So that, Users can login to Web/App/DB servers via Bastion server only
**/

output "bastion_ssh_key" {
  value       = ibm_is_ssh_key.iac_shared_ssh_key
  description = "SSH Key created dynamically from Bastion vsi for app/web/db servers"
}
