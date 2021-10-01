/**
*   The file is used for providing the region specific alias. 
*   The alias are used for creating infrastructure in different regions.
*   The alias value should match with locals and providers block present in main.tf file in root module
*
*/

# IBM cloud api key
provider "ibm" {
  ibmcloud_api_key = var.api_key
}

# Region: Dallas
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "us-south"
  region           = "us-south"
}

# Region: Washington DC
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "us-east"
  region           = "us-east"
}

# Region: London
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "eu-gb"
  region           = "eu-gb"
}

# Region: Frankfurt
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "eu-de"
  region           = "eu-de"
}

# Region: Tokyo
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "jp-tok"
  region           = "jp-tok"
}

# Region: Sydney
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "au-syd"
  region           = "au-syd"
}

# Region: Osaka
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "jp-osa"
  region           = "jp-osa"
}

# Region: Toronto
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "ca-tor"
  region           = "ca-tor"
}

# Region: Sao Paulo
provider "ibm" {
  ibmcloud_api_key = var.api_key
  alias            = "br-sao"
  region           = "br-sao"
}
