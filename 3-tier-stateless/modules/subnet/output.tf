/**
#################################################################################################################
*                                 Subnets Output Variable Section
#################################################################################################################
**/

/**
* Output Variable
* Element : Web subnets ids
* This variable will output the id's of Web Subnet
**/

output "web_subnet_ids" {
  value       = ibm_is_subnet.web_subnet.*.id
  description = "Subnet ids of Web for all zones"
}

/**
* Output Variable
* Element : App subnets ids
* This variable will output the id's of App Subnet
**/

output "app_subnet_ids" {
  value       = ibm_is_subnet.app_subnet.*.id
  description = "Subnet ids of App for all zones"
}

/**
* Output Variable
* Element : DB subnets ids
* This variable will output the id's of DB Subnet
**/
output "db_subnet_ids" {
  value       = ibm_is_subnet.db_subnet.*.id
  description = "Subnet ids of DB for all zones"
}

/**               
#################################################################################################################
*                                   End of the Output Section 
#################################################################################################################
**/