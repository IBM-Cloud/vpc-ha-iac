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
  resource_group = var.resource_group_id
}

/**
 * Locals
 * This resource will be used to create and calculate local variables containing Subnet IP count.
 **/
locals {
  valid_ip_counts   = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
  instance_ip_count = var.total_instance + 5 + 2 # 5:reservedIP, 2:load_balancer  
  subnet_ip_count   = [for valid_ip_count in local.valid_ip_counts : valid_ip_count if valid_ip_count > local.instance_ip_count][0]
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
  source             = "./modules/subnet"
  vpc_id             = ibm_is_vpc.vpc.id
  prefix             = var.prefix
  zones              = var.zones[var.region]
  resource_group_id  = var.resource_group_id
  ip_count           = local.subnet_ip_count
  public_gateway_ids = module.public_gateway.pg_ids
  depends_on         = [ibm_is_vpc.vpc]
}

/**
* Calling the Security Group module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group: The resource group id
* depend_on: This ensures that the vpc object will be created before the subnets
**/

module "security_group" {
  source            = "./modules/security_group"
  vpc_id            = ibm_is_vpc.vpc.id
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  my_public_ip      = var.my_public_ip
  alb_port          = var.alb_port
  dlb_port          = var.dlb_port
  bastion_sg        = module.bastion.bastion_sg
  app_os_type       = var.app_os_type
  web_os_type       = var.web_os_type
  db_os_type        = var.db_os_type
  depends_on        = [ibm_is_vpc.vpc, module.subnet.ibm_is_subnet]
}

/**
* Data Resource
* Element : SSH Key
* This will return the ssh key id of the User-ssh-key. This is the existing ssh key of user which will be used to login to Bastion server.
**/
data "ibm_is_ssh_key" "ssh_key_id" {
  name = var.user_ssh_key
}

/**
* Calling the Bastion module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* user_ssh_key: This is the name of an existing ssh key of user which will be used to login to Bastion server. Its private key content should be there in path ~/.ssh/id_rsa 
    And public key content should be uploaded to IBM cloud. If you don't have an existing key then create one using ssh-keygen -t rsa -b 4096 -C "user_ID" command.
* bastion_ssh_key: This key will be created dynamically on the bastion VSI. It will be used to login to Web/App/DB servers via Bastion.
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* subnet: Subnet ID for the bastion VSI
* security_group_id: Security group id to be attached with bastion VSI
* bastion_profile: The Profile needed for Bastion VSI creation
* depends_on: This ensures that the subnet and security group object will be created before the bastion
**/

module "bastion" {
  source                = "./modules/bastion"
  prefix                = var.prefix
  vpc_id                = ibm_is_vpc.vpc.id
  user_ssh_key          = [data.ibm_is_ssh_key.ssh_key_id.id]
  bastion_ssh_key       = var.bastion_ssh_key_var_name
  my_public_ip          = var.my_public_ip
  resource_group_id     = var.resource_group_id
  zones                 = var.zones[var.region]
  api_key               = var.api_key
  region                = var.region
  bastion_profile       = var.bastion_profile
  bastion_ip_count      = var.bastion_ip_count
  bastion_os_type       = var.bastion_os_type
  local_machine_os_type = var.local_machine_os_type
  bastion_image         = var.bastion_image
  depends_on            = [ibm_is_vpc.vpc]
}

# /**
# * Data Resource
# * Element : SSH Key
# * This will return the ssh key id of the Bastion-ssh-key. This is the dynamically generated ssh key from bastion server itself.
# * This key will be attached to all the app servers.
# *
# * Note: If you get this error on terraform apply -> Error: No SSH Key found with name {prefix}-bastion-ssh-key
# * Then with terraform destroy command use -refresh=false flag at this time only.
# * DO NOT use this flag on any other time, As it stops the state refresh.
# * Now, before re-running the script -> Check the Bastion server image version. If it is windows, 
# * It should be "Windows Server 2019 Standard Edition (amd64) ibm-windows-server-2019-full-standard-amd64-6" only.
# **/

data "ibm_is_ssh_key" "bastion_key_id" {
  name = "${var.prefix}${var.bastion_ssh_key_var_name}"
  depends_on = [
    module.bastion,
  ]
}

/**
* Module: Public Gateway module for region
* Calling the Public Gateway module with the following required parameters
* source: Path of the Source Code of the Public Gateway Module
* vpc_id: VPC ID of region2 for the the Public Gateway Module. Public Gateways will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is us-east then zones would be ["us-east-1","us-east-2","us-east-3"]
* depends_on: This ensures that the vpc object will be created before the Public Gateway Module
**/
module "public_gateway" {
  source            = "./modules/public_gateway"
  vpc_id            = ibm_is_vpc.vpc.id
  prefix            = "${var.prefix}region-"
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  depends_on        = [ibm_is_vpc.vpc]
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
  source            = "./modules/load_balancer"
  vpc_id            = ibm_is_vpc.vpc.id
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  web_subnet        = module.subnet.web_subnet_ids
  app_subnet        = module.subnet.app_subnet_ids
  db_subnet         = module.subnet.db_subnet_ids
  alb_port          = var.alb_port
  dlb_port          = var.dlb_port
  web_target        = module.instance.web_target
  app_target        = module.instance.app_target
  db_target         = module.instance.db_target
  lb_protocol       = var.lb_protocol
  lb_algo           = var.lb_algo
  lb_port_number    = var.lb_port_number
  lb_sg             = module.security_group.lb_sg
  web_vsi           = module.instance.web_vsi
  app_vsi           = module.instance.app_vsi
  db_vsi            = module.instance.db_vsi
  total_instance    = range(var.total_instance)
  depends_on        = [module.subnet.ibm_is_subnet, module.instance.ibm_is_instance]
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
  source            = "./modules/instance"
  prefix            = var.prefix
  vpc_id            = ibm_is_vpc.vpc.id
  ssh_key           = [data.ibm_is_ssh_key.bastion_key_id.id]
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  web_image         = var.web_image
  app_image         = var.app_image
  db_image          = var.db_image
  web_profile       = var.web_profile
  app_profile       = var.app_profile
  db_profile        = var.db_profile
  web_subnet        = module.subnet.web_subnet_ids
  app_subnet        = module.subnet.app_subnet_ids
  db_subnet         = module.subnet.db_subnet_ids
  bastion_sg        = module.bastion.bastion_sg
  app_sg            = module.security_group.app_sg
  web_sg            = module.security_group.web_sg
  db_sg             = module.security_group.db_sg
  wlb_id            = module.load_balancer.web_lb_id
  dlb_id            = module.load_balancer.db_lb_id
  alb_id            = module.load_balancer.app_lb_id
  total_instance    = range(var.total_instance)
  depends_on        = [module.subnet.ibm_is_subnet, module.security_group, module.bastion]
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
  value = module.bastion.bastion_ip
}

