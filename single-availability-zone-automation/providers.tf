provider "ibm" {
  ibmcloud_api_key = var.api_key
  region           = var.regions[var.zone]
  ibmcloud_timeout = 300
}
