/**
#################################################################################################################
*                                 VPC Output Variable Section
#################################################################################################################
**/


/**
* Output Variable
* Element : VPC
* VPC id
* This variable will output the IP address and DNS for App, DB and Web
**/
output "id" {
  description = "This variable will display the private and public IP addresses and DNS of load balancers"
  value       = ibm_is_vpc.vpc.id
}

/**
* Output Variable
* Element : VPC
* VPC crn
* This variable will output the CRN value of VPC.
**/
output "crn" {
  description = "This variable will display the CRN id of VPC"
  value       = ibm_is_vpc.vpc.crn
}