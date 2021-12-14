/**
#################################################################################################################
*                                 Database Instance Output Variable Section
#################################################################################################################
**/


/**
* Output Variable
* Element : DB Target
* Primary IP address for the web VSI
* This variable will return array of IP address for the DB VSI
**/
output "db_target" {
  value       = ibm_is_instance.db.*.primary_network_interface.0.primary_ipv4_address
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.db]
}

/**
* Output Variable
* Element : Compute instance
* This will return the db vsi reference
**/
output "db_vsi" {
  value       = ibm_is_instance.db
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.db]
}
