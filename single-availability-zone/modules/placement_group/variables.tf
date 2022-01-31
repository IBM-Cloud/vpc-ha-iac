/**
#################################################################################################################
*                           Variable Section for the Placement Group Module.
*                                 Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group_id
* Type: String
* Desc: Resource Group ID to be used for resources creation
*/

variable "resource_group_id" {
  description = "Resource Group Name is used to separate the resources in a group."
  type        = string
}

/**
* Name: prefix
* Type: String
* Desc: This is the prefix text that will be prepended in every resource name created by this script.
**/

variable "prefix" {
  description = "Prefix for all the resources."
  type        = string
}

/**
* Name: db_pg_strategy
* Type: string
* Desc: The strategy for Database servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
**/

variable "db_pg_strategy" {
  description = "The strategy for Database servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources."
  type        = string
}

/**
* Name: web_pg_strategy
* Type: string
* Desc: The strategy for Web servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
**/

variable "web_pg_strategy" {
  description = "The strategy for Web servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources."
  type        = string
}

/**
* Name: app_pg_strategy
* Type: string
* Desc: The strategy for App servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
**/

variable "app_pg_strategy" {
  description = "The strategy for App servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources."
  type        = string
}

/**
* Name: tags
* Type: list
* Desc: The user tags to attach to the placement group.
*/

variable "tags" {
  description = "The user tags to attach to the placement group."
  type        = list(any)
  default     = null
}

/**
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/