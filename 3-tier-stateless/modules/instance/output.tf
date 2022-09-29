/**
#################################################################################################################
*                                 Instances Output Variable Section
#################################################################################################################
**/


/**
* Output Variable
* Element : Web Target
* Primary IP address for the web VSI
* This variable will return array of IP address for the Web VSI
**/
output "web_target" {
  value       = ibm_is_instance.web.*.primary_network_interface.0.primary_ipv4_address
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.web]
}

/**
* Output Variable
* Element : App Target
* Primary IP address for the db VSI
* This variable will return array of IP address for the DB VSI
**/
output "app_target" {
  value       = ibm_is_instance.app.*.primary_network_interface.0.primary_ipv4_address
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.app]
}

/**
* Output Variable
* Element : Compute instance
* This will return the web vsi reference
**/
output "web_vsi" {
  value       = ibm_is_instance.web
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.web]
}

/**
* Output Variable
* Element : Compute instance
* This will return the app vsi reference
**/
output "app_vsi" {
  value       = ibm_is_instance.app
  description = "Target primary network interface address"
  depends_on  = [ibm_is_instance.app]
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
#################################################################################################################
*                                   End of the Output Section 
#################################################################################################################
**/