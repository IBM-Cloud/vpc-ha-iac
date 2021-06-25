/**
----------------------------------------------------------------|
* Total Resource Count for the default value of this project:   |
----------------------------------------------------------------|
* VPC Count                     = 1
* Subnet Count                  = 10
* Security Group Count          = 5
* Security Group Rules          = 16
* Load Balancers                = 3
* Load Balancer Listener        = 3
* Load Balancer Pool            = 3
* Load Balancer Pool Member     = 3
* Bastion VSI                   = 1
* Instance Template             = 2
* Instance Group                = 2
* Instance Group Manager        = 2
* Instance Group Policy         = 8
* Database VSI                  = 3
* Time Sleep                    = 1
* Data Volume                   = 3
* Floating IP                   = 1
* Null Resource                 = 1
* Local File                    = 1
* Data Source ssh_key           = 1
* Dynamic ssh_key               = 1
*--------------------------------------|
*--------------------------------------|
* Total Resources               = 71   |
*--------------------------------------|
*--------------------------------------|
**/

resource "ibm_is_vpc" "vpc" {
  name           = "${var.prefix}vpc"
  resource_group = var.resource_group_id
}

/**
* Calling the Subnet module with the following required parameters
* source: Path of the Source Code of the Subnet Module
* vpc_id: VPC ID for the the Subnet Module. Subnets will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* ip_count: Total number of IP Address for each subnet
* depends_on: This ensures that the vpc object will be created before the Subnet Module
**/
module "subnet" {
  source            = "./modules/subnets"
  vpc_id            = ibm_is_vpc.vpc.id
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  ip_count          = var.ip_count
  depends_on        = [ibm_is_vpc.vpc]
}

/**
* Calling the Security Group module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* user_ip_address: User's Public IP address which will be used to login to Bastion VSI from their local machine
* alb_port: This is the Application load balancer listener port
* dlb_port: This is the DB load balancer listener port
* depends_on: This ensures that the vpc and subnet object will be created before the security groups
**/

module "security_group" {
  source            = "./modules/security_groups"
  vpc_id            = ibm_is_vpc.vpc.id
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  user_ip_address   = var.user_ip_address
  alb_port          = var.alb_port
  dlb_port          = var.dlb_port
  depends_on        = [ibm_is_vpc.vpc, module.subnet]
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
  source            = "./modules/bastion"
  prefix            = var.prefix
  vpc_id            = ibm_is_vpc.vpc.id
  user_ssh_key      = [data.ibm_is_ssh_key.ssh_key_id.id]
  bastion_ssh_key   = var.bastion_ssh_key_var_name
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  subnet            = module.subnet.sub_objects["bastion"].id
  security_group_id = module.security_group.sg_objects["bastion"].id
  bastion_profile   = var.bastion_profile
  depends_on        = [module.subnet, module.security_group]
}

/**
* Calling the Load Balancer module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* lb_sg: load balancer security group to be attached with all the load balancers.
* subnets: We are passing the Map of subnet objects. It includes all the subnet IDs
* alb_port: This is the Application load balancer listener port
* dlb_port: This is the DB load balancer listener port
* db_target: DB target id
* db_vsi: DB VSI id
* total_instance: Total instances that will be created per zones per tier.
* depends_on: This ensures that the vpc, subnet and security group object will be created before the load balancer
**/

module "load_balancer" {
  source            = "./modules/load_balancers"
  vpc_id            = ibm_is_vpc.vpc.id
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  lb_sg             = module.security_group.sg_objects["lb"].id
  subnets           = module.subnet.sub_objects
  alb_port          = var.alb_port
  dlb_port          = var.dlb_port
  db_target         = module.instance.db_target
  db_vsi            = module.instance.db_vsi
  total_instance    = range(var.total_instance)
  depends_on        = [ibm_is_vpc.vpc, module.subnet, module.security_group]
}


/**
* Calling the Instance module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* bandwidth: Bandwidth per second in GB. The possible values are 3, 5 and 10
* size: Storage size in GB. The value should be between 10 and 2000
* db_image: Image id to be used with DB VSI
* db_profile: Hardware configuration profile for the DB VSI
* subnets: Subnet ID for the Database VSI
* db_sg: Security group id to be attached with DB VSI
* dlb_id: DB Load balancer ID to be integrated with DB instances
* total_instance: Total instances that will be created per zones per tier.
* depends_on: This ensures that the subnets, security group and bastion object will be created before the instance
**/

module "instance" {
  source            = "./modules/instance"
  prefix            = var.prefix
  vpc_id            = ibm_is_vpc.vpc.id
  ssh_key           = [module.bastion.bastion_ssh_key.id]
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  bandwidth         = var.bandwidth
  size              = var.size
  db_image          = var.db_image
  db_profile        = var.db_profile
  subnets           = module.subnet.sub_objects["db"].*.id
  db_sg             = module.security_group.sg_objects["db"].id
  dlb_id            = tostring(module.load_balancer.objects["lb"]["db"].id)
  total_instance    = range(var.total_instance)
  depends_on        = [module.subnet.ibm_is_subnet, module.security_group, module.bastion]
}

/**
* Calling the Instance Group module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* ssh_key: This ssh_key got generated dynamically on the bastion server and further will be attached with all the other VSI to be connected from Bastion Server only
* subnets: We are passing the Map of subnet objects. It includes all the subnet IDs
* sg_objects: We are passing the Map of security group objects. It includes all the security groups IDs
* objects: This variable will contain the objects of LB, LB Pool and LB Listeners. It includes IDs of load balancer, load balancer pools and load balancer listeners.
* app_config: Application configuration Map
* web_config: Web configuration Map
* depends_on: This ensures that the vpc and other objects will be created before the instance group
**/

module "instance_group" {
  source                = "./modules/instance_groups"
  vpc_id                = ibm_is_vpc.vpc.id
  prefix                = var.prefix
  resource_group_id     = var.resource_group_id
  zones                 = var.zones[var.region]
  ssh_key               = [module.bastion.bastion_ssh_key.id]
  subnets               = module.subnet.sub_objects
  sg_objects            = module.security_group.sg_objects
  objects               = module.load_balancer.objects
  app_config            = var.app_config
  web_config            = var.web_config
  web_max_servers_count = var.web_max_servers_count
  web_min_servers_count = var.web_min_servers_count
  web_cpu_percent       = var.web_cpu_percent
  app_max_servers_count = var.app_max_servers_count
  app_min_servers_count = var.app_min_servers_count
  app_cpu_percent       = var.app_cpu_percent
  depends_on            = [module.bastion, module.load_balancer]
}
