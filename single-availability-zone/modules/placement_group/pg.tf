/**
#################################################################################################################
*                           Resources Section for the Placement Group Module.
#################################################################################################################
*/

/**
* Placement Group resource block
* Element : Placement Group for Database servers
* This resource will be used to create a DB placement group.
**/

resource "ibm_is_placement_group" "db_placement_group" {
  strategy       = var.db_pg_strategy
  name           = "${var.prefix}db-pg"
  resource_group = var.resource_group_id
  tags           = var.tags
}

/**
* Placement Group resource block
* Element : Placement Group for Web servers
* This resource will be used to create a Web placement group.
**/

resource "ibm_is_placement_group" "web_placement_group" {
  strategy       = var.web_pg_strategy
  name           = "${var.prefix}web-pg"
  resource_group = var.resource_group_id
  tags           = var.tags
}

/**
* Placement Group resource block
* Element : Placement Group for App servers
* This resource will be used to create a App placement group.
**/

resource "ibm_is_placement_group" "app_placement_group" {
  strategy       = var.app_pg_strategy
  name           = "${var.prefix}app-pg"
  resource_group = var.resource_group_id
  tags           = var.tags
}