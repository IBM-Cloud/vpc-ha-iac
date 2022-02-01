/**
#################################################################################################################
*                              Placement Group Module Output Variable Section
#################################################################################################################
**/

/**
* Output Variable
* Element : DB Placement Group
* Placement group ID for Database servers
* This variable will return the ID of the DB Placement group
**/
output "db_pg_id" {
  value       = ibm_is_placement_group.db_placement_group.id
  description = "Placement group ID for Database servers"
}

/**
* Output Variable
* Element : Web Placement Group
* Placement group ID for Web servers
* This variable will return the ID of the Web Placement group
**/
output "web_pg_id" {
  value       = ibm_is_placement_group.web_placement_group.id
  description = "Placement group ID for Web servers"
}

/**
* Output Variable
* Element : App Placement Group
* Placement group ID for App servers
* This variable will return the ID of the App Placement group
**/
output "app_pg_id" {
  value       = ibm_is_placement_group.app_placement_group.id
  description = "Placement group ID for App servers"
}