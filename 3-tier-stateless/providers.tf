provider "ibm" {
  ibmcloud_api_key = var.api_key
  region           = var.region
  ibmcloud_timeout = 300
}
