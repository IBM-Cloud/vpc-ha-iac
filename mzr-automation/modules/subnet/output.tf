/**
#################################################################################################################
*                                 Subnets Output Variable Section
#################################################################################################################
**/


/**
* Output Variable: sub_objects
* Element : sub_objects objects
* This variable will return the objects for the following subnets
* Objects: 
* app_subnet
* db_subnet
* web_subnet
**/
output "sub_objects" {
  description = "This output variable will expose the objects of all subnets"
  value = {
    "app" = ibm_is_subnet.app_subnet,
    "db"  = ibm_is_subnet.db_subnet,
    "web" = ibm_is_subnet.web_subnet
  }
}
