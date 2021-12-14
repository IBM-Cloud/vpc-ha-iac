/**
#################################################################################################################
*                           Resources Section for the VPC Module.
#################################################################################################################
*/

/**
* VPC: Virtual Private Cloud
* Element : vpc
* This resource will be used to create a vpc.
**/
resource "ibm_is_vpc" "vpc" {
  name           = "${var.prefix}vpc"
  resource_group = var.resource_group_id
}