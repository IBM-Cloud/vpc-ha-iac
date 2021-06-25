/**
#################################################################################################################
*                     Terraform Initialization for this Module and Version Specification
*                               Start of the Terraform Initialization Section 
#################################################################################################################
**/
terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.26.0"
    }
  }
}


/**
#################################################################################################################
*                               End of the Terraform Initialization Section 
#################################################################################################################
**/
