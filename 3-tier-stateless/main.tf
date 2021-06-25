/**
* Resource Count for this project:
* VPC Count             = 1
* Subnet Count          = 10
* Security Group Count  = 3
* Security Group Rule   = 5
* Load Balancers        = 3
* 
**/

resource "ibm_is_vpc" "vpc" {
  name           = "${var.prefix}vpc"
  resource_group = var.resource_group
}

/**
* Calling the Subnet module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group: The resource group id
* depend_on: This ensures that the vpc object will be created before the subnets
**/
module "subnet" {
  source         = "./modules/subnets"
  vpc_id         = ibm_is_vpc.vpc.id
  prefix         = var.prefix
  zones          = var.zones[var.region]
  resource_group = var.resource_group
  depends_on     = [ibm_is_vpc.vpc]
  ip_count       = var.ip_count
}

/**
  OUTPUT Section for the terraform script
**/

# output "bastion-subnet" {
#   value = module.subnet.bastion_subnet_id
# }

# output "web-subnet" {
#   value = module.subnet.web_subnet_ids
# }

# output "app-subnet" {
#   value = module.subnet.app_subnet_ids
# }

# output "db-subnet" {
#   value = module.subnet.db_subnet_ids
# }

/**
* Calling the Security Group module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group: The resource group id
* depend_on: This ensures that the vpc object will be created before the subnets
**/

module "security_group" {
  source         = "./modules/security_groups"
  vpc_id         = ibm_is_vpc.vpc.id
  prefix         = var.prefix
  resource_group = var.resource_group
  depends_on     = [ibm_is_vpc.vpc, module.subnet.ibm_is_subnet]
}


/**
* Calling the Load Balancer module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group: The resource group id
* web_subnet: IDs of web subnet
* app_subnet: IDs of app subnet
* db_subnet: IDs of db subnet
* depend_on: This ensures that the vpc object will be created before the subnets
**/

module "load_balancer" {
  source         = "./modules/load_balancers"
  vpc_id         = ibm_is_vpc.vpc.id
  prefix         = var.prefix
  resource_group = var.resource_group
  zones          = var.zones[var.region]
  web_subnet     = module.subnet.web_subnet_ids
  app_subnet     = module.subnet.app_subnet_ids
  db_subnet      = module.subnet.db_subnet_ids
  web_target     = module.instance.web_target
  app_target     = module.instance.app_target
  db_target      = module.instance.db_target
  lb_sg          = module.security_group.lb_sg
  web_vsi        = module.instance.web_vsi
  app_vsi        = module.instance.app_vsi
  db_vsi         = module.instance.db_vsi
  total_instance = range(var.total_instance)
  depends_on     = [module.subnet.ibm_is_subnet, module.instance.ibm_is_instance]
}

/**
* Data Resource
* Element : App Target
* Primary IP address for the db VSI
* This variable will return array of IP address for the DB VSI
**/
data "ibm_is_ssh_key" "ssh_key_id" {
  name = var.ssh_key
}
/**
* Calling the Load Balancer module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group: The resource group id
* web_subnet: IDs of web subnet
* app_subnet: IDs of app subnet
* db_subnet: IDs of db subnet
* depend_on: This ensures that the vpc object will be created before the subnets
**/

module "instance" {
  source         = "./modules/instances"
  prefix         = var.prefix
  vpc_id         = ibm_is_vpc.vpc.id
  ssh_key        = [data.ibm_is_ssh_key.ssh_key_id.id]
  resource_group = var.resource_group
  zones          = var.zones[var.region]

  bastion_subnet = module.subnet.bastion_subnet_id
  web_subnet     = module.subnet.web_subnet_ids
  app_subnet     = module.subnet.app_subnet_ids
  db_subnet      = module.subnet.db_subnet_ids
  bastion_sg     = module.security_group.bastion_sg
  app_sg         = module.security_group.app_sg
  web_sg         = module.security_group.web_sg
  db_sg          = module.security_group.db_sg
  wlb_id         = module.load_balancer.web_lb_id
  dlb_id         = module.load_balancer.db_lb_id
  alb_id         = module.load_balancer.app_lb_id
  total_instance = range(var.total_instance)
  depends_on     = [module.subnet.ibm_is_subnet]
}

/**
*                                Web Load Balancers Sections
*                                         Starts Here
**/
output "lb-web-ip" {
  value = module.load_balancer.web_lb_ip
}
output "lb-web-dns" {
  value = module.load_balancer.web_lb_hostname
}


/**
*                                App Load Balancers Sections
*                                         Starts Here
**/

output "lb-app-ip" {
  value = module.load_balancer.app_lb_ip
}
output "lb-app-dns" {
  value = module.load_balancer.app_lb_hostname
}


/**
*                                DB Load Balancers Sections
*                                         Starts Here
**/

output "lb-db-ip" {
  value = module.load_balancer.db_lb_ip
}
output "lb-db-dns" {
  value = module.load_balancer.db_lb_hostname
}

/**
*                                DB Load Balancers Sections
*                                         Ends Here
**/

output "vsi-web-ips" {
  value = module.instance.web_target
}

output "vsi-app-ips" {
  value = module.instance.app_target
}

output "vsi-db-ips" {
  value = module.instance.db_target
}

output "vsi-bastion-ip" {
  value = module.instance.bastion_ip
}

