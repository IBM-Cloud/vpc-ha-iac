/**
----------------------------------------------------------------------|
* Total Resource Count for the default value of this project:         |
----------------------------------------------------------------------|
----------------------------------------------------------------------|
RESOURCE NAME                   REGION1  |  REGION2  |   TOTAL        |
----------------------------------------------------------------------|
* COS Instannce                    01    +     -         =  01
* COS Bucket                       01    +     -         =  01
* COS Object                       01    +     -         =  01
* CIS GLB Instance                 01    +     -         =  01
* CIS GLB Domain                   01    +     -         =  01
* CIS Global Load Balancer         01    +     -         =  01
* CIS GLB Health Check             01    +     01        =  02
* CIS GLB Origin Pool              01    +     01        =  02
* VPC                              01    +     01        =  02
* Transit Gateway                  01    +     -         =  01
* Transit Gateway Connection       01    +     01        =  02
* Public Gateway                   03    +     03        =  06
* Subnet                           09    +     09        =  18
* Security Group                   05    +     05        =  10
* Security Group Rules             26    +     26        =  52
* Load Balancers                   02    +     02        =  04
* Load Balancer Listener           02    +     02        =  04
* Load Balancer Pool               02    +     02        =  04
* Bastion VSI                      01    +     01        =  02
* Instance Template                02    +     02        =  04
* Instance Group                   02    +     02        =  04
* Instance Group Manager           02    +     02        =  04
* Instance Group Policy            08    +     08        =  16
* Database VSI                     02    +     02        =  04
* Time Sleep                       01    +     01        =  02
* Data Volume                      02    +     02        =  04
* Floating IP                      01    +     01        =  02
* Null Resource                    01    +     01        =  02
* Data Source ssh_key              04    +     04        =  08
* Data Source Auth Token           01    +     01        =  02
* Data Source IG Member            02    +     02        =  04

*---------------------------------------------------------------------|
*---------------------------------------------------------------------|
* Total Resources                  90    +     83        = 173        |
*---------------------------------------------------------------------|
*---------------------------------------------------------------------|
**/
/**
  The user needs to update the following two variable with his/her
  desired regions. It would reflect inside the resource names.
  These regions should be identical to the provider regions we are using.
*/

locals {
  region1 = "jp-tok"
  region2 = "jp-osa"
}

/**
* Cross Region service provides higher durability and availability than using a single region, at the cost of slightly higher latency. 
* This service is available today in the U.S., E.U., and A.P. areas.
* Calling the COS Bucket module with the following required parameters
* source: Path of the Source Code of the COS Bucket Module
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* cos_bucket_plan: List of available plan for the COS bucket. e.g. "lite" and "standard"
* cross_region_location: Cross Region service provides higher durability and availability than using a single region, 
*       at the cost of slightly higher latency. 
*       This service is available today in the U.S., E.U., and A.P. areas.
* storage_class: Storage class helps in choosing a right storage plan and location and helps in reducing the cost.
* bucket_location: The location of the COS bucket
* obj_key: The name of an object in the COS bucket. This is used to identify our object.
* obj_content: Literal string value to use as an object content, which will be uploaded as UTF-8 encoded text. Conflicts with content_base64 and content_file. 
**/

module "cos" {
  source                = "./modules/cos"
  prefix                = "${var.prefix}region-${local.region1}-"
  resource_group_id     = var.resource_group_id
  cos_bucket_plan       = var.cos_bucket_plan
  cross_region_location = var.cross_region_location
  storage_class         = var.storage_class
  bucket_location       = var.bucket_location
  obj_key               = var.obj_key
  obj_content           = var.obj_content
}

/**
* Calling the VPC module for region1 with the following required parameters
* source: Path of the Source Code of the Public Gateway Module
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-tok
**/

module "vpc_region1" {
  source            = "./modules/vpc"
  prefix            = "${var.prefix}region-${local.region1}-"
  resource_group_id = var.resource_group_id
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Calling the VPC module for region2 with the following required parameters
* source: Path of the Source Code of the Public Gateway Module
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-osa
**/
module "vpc_region2" {
  source            = "./modules/vpc"
  prefix            = "${var.prefix}region-${local.region2}-"
  resource_group_id = var.resource_group_id
  providers = {
    ibm = ibm.jp-osa
  }
}

/**
* Calling the transit_gateway module with the following required parameters
* source: Path of the Source Code of the Transit Gateway Module
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* location: Providing the location where we want to create Transit Gateway
* vpc_crn_region1: We are passing VPC CRN_id value for Region-1
* vpc_crn_region2: We are passing VPC CRN_id value for Region-2
* depends_on: This ensures that the VPC objects will be created before the transit gateway
**/

module "transit_gateway" {
  source            = "./modules/transit_gateway"
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  location          = local.region1
  vpc_crn_region1   = module.vpc_region1.crn
  vpc_crn_region2   = module.vpc_region2.crn
  depends_on        = [module.vpc_region1, module.vpc_region2]
}

/**
 * Data Resource
 * Element : SSH Key
 * This will return the ssh key/keys id of the User-ssh-key. This is the existing ssh key of user which will be used to login to Bastion server.
 **/
data "ibm_is_ssh_key" "ssh_key_id_region1" {
  count    = length(local.user_ssh_key_list)
  name     = local.user_ssh_key_list[count.index]
  provider = ibm.jp-tok
}

/**
* Calling the Bastion module with the following required parameters in Region-1
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* user_ssh_key: This is the list of the existing ssh key/keys of user which will be used to login to Bastion server. Its private key content should be there in path ~/.ssh/id_rsa 
* And public key content should be uploaded to IBM cloud. If you don't have an existing key then create one using ssh-keygen -t rsa -b 4096 -C "user_ID" command.
* my_public_ip: User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* region1: User specified Region-1 code
* region2: User specified Region-2 code
* api_key: Api key of user which will be used to login to IBM cloud in provisioner section
* bastion_profile: The Profile needed for Bastion VSI creation
* bastion_image: The Bastion Image needed for Bastion VSI creation
* bastion_os_type: OS image to be used [windows | linux] for Bastion server
* bastion_ip_count: IP count is the total number of total_ipv4_address_count for Bastion Subnet
* local_machine_os_type: Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply
* depends_on: This ensures that the VPC object will be created before the bastion
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-tok
**/

module "bastion_region1" {
  source                 = "./modules/bastion"
  prefix                 = "${var.prefix}bastion1-"
  vpc_id                 = module.vpc_region1.id
  user_ssh_key           = data.ibm_is_ssh_key.ssh_key_id_region1.*.id
  public_ip_address_list = local.public_ip_address_list
  resource_group_id      = var.resource_group_id
  zones                  = var.zones[local.region1]
  region1                = local.region1
  region2                = local.region2
  api_key                = var.api_key
  bastion_image          = var.bastion_image_region1
  bastion_profile        = var.bastion_profile
  bastion_os_type        = var.bastion_os_type
  bastion_ip_count       = var.bastion_ip_count
  local_machine_os_type  = var.local_machine_os_type
  depends_on             = [module.vpc_region1]
  providers = {
    ibm = ibm.jp-tok
  }
}

# /**
# * Data Resource
# * Element : SSH Key
# * This will return the ssh key/keys id of the User-ssh-key. This is the existing ssh key of user which will be used to login to Bastion server.
# **/
data "ibm_is_ssh_key" "ssh_key_id_region2" {
  count    = length(local.user_ssh_key_list)
  name     = local.user_ssh_key_list[count.index]
  provider = ibm.jp-osa
}

/**
* Calling the Bastion module with the following required parameters in Region-2
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* user_ssh_key: This is the list  of  existing ssh key/keys of user which will be used to login to Bastion server. Its private key content should be there in path ~/.ssh/id_rsa 
*    And public key content should be uploaded to IBM cloud. If you don't have an existing key then create one using ssh-keygen -t rsa -b 4096 -C "user_ID" command.
* my_public_ip: User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-osa then zones would be ["jp-osa-1","jp-osa-2","jp-osa-3"]
* region1: User specified Region-1 code
* region2: User specified Region-2 code
* api_key: api key of user which will be used to login to IBM cloud in provisioner section
* bastion_profile: The Profile needed for Bastion VSI creation
* bastion_image: The Bastion Image needed for Bastion VSI creation
* bastion_os_type: OS image to be used [Windows | Linux] for Bastion server
* bastion_ip_count: IP count is the total number of total_ipv4_address_count for Bastion Subnet
* local_machine_os_type: Operating System to be used [Windows | Mac | Linux] for your local machine which is running terraform apply
* depends_on: This ensures that the VPC object will be created before the bastion
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-osa
**/

module "bastion_region2" {
  source                 = "./modules/bastion"
  prefix                 = "${var.prefix}bastion2-"
  vpc_id                 = module.vpc_region2.id
  user_ssh_key           = data.ibm_is_ssh_key.ssh_key_id_region2.*.id
  public_ip_address_list = local.public_ip_address_list
  resource_group_id      = var.resource_group_id
  zones                  = var.zones[local.region2]
  region1                = local.region1
  region2                = local.region2
  api_key                = var.api_key
  bastion_image          = var.bastion_image_region2
  bastion_profile        = var.bastion_profile
  bastion_os_type        = var.bastion_os_type
  bastion_ip_count       = var.bastion_ip_count
  local_machine_os_type  = var.local_machine_os_type
  depends_on             = [module.vpc_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}

/**
* Calling the Data Sources module with the following required parameters in Region-1
* source: Source Directory of the Module
* bastion1_key: SSH key name created by the Bastion-1 server
* bastion2_key: SSH key name created by the Bastion-2 server
* depends_on: This ensures that the data sources will be queried after bastion-1 and bastion-2 resource completion
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-tok
*
* Note: If you get this error on terraform apply -> Error: No SSH Key found with name {prefix}-bastion-ssh-key
* Then with terraform destroy command use -refresh=false flag at this time only.
* DO NOT use this flag on any other time, As it stops the state refresh.
* Now, before re-running the script -> Check the Bastion server image version. If it is windows, 
* It should be "Windows Server 2019 Standard Edition (amd64) ibm-windows-server-2019-full-standard-amd64-6" only.
**/

module "ssh_key_data_sources_region1" {
  source       = "./modules/ssh_key"
  bastion1_key = "${var.prefix}bastion1-ssh-key"
  bastion2_key = "${var.prefix}bastion2-ssh-key"
  depends_on   = [module.bastion_region1, module.bastion_region2]
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Calling the Data Sources module with the following required parameters in Region-2
* source: Source Directory of the Module
* bastion1_key: SSH key name created by the Bastion-1 server
* bastion2_key: SSH key name created by the Bastion-2 server
* depends_on: This ensures that the data sources will be queried after bastion-1 and bastion-2 resource completion
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-osa
*
* Note: If you get this error on terraform apply -> Error: No SSH Key found with name {prefix}-bastion-ssh-key
* Then with terraform destroy command use -refresh=false flag at this time only.
* DO NOT use this flag on any other time, As it stops the state refresh.
* Now, before re-running the script -> Check the Bastion server image version. If it is windows, 
* It should be "Windows Server 2019 Standard Edition (amd64) ibm-windows-server-2019-full-standard-amd64-6" only.
**/

module "ssh_key_data_sources_region2" {
  source       = "./modules/ssh_key"
  bastion1_key = "${var.prefix}bastion1-ssh-key"
  bastion2_key = "${var.prefix}bastion2-ssh-key"
  depends_on   = [module.bastion_region1, module.bastion_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}

/**
* Module: Public Gateway module for region1
* Calling the Public Gateway module with the following required parameters
* source: Path of the Source Code of the Public Gateway Module
* vpc_id: VPC ID of region1 for the the Public Gateway Module. Public Gateways will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* depends_on: This ensures that the vpc object will be created before the Public Gateway Module
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
  Here the provider name is ibm and value is jp-tok
**/
module "pg_region1" {
  source            = "./modules/public_gateway"
  vpc_id            = module.vpc_region1.id
  prefix            = "${var.prefix}region-${local.region1}-"
  resource_group_id = var.resource_group_id
  zones             = var.zones[local.region1]
  depends_on        = [module.vpc_region1]
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Module: Public Gateway module for region2
* Calling the Public Gateway module with the following required parameters
* source: Path of the Source Code of the Public Gateway Module
* vpc_id: VPC ID of region2 for the the Public Gateway Module. Public Gateways will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is jp-osa then zones would be ["jp-osa-1","jp-osa-2","jp-osa-3"]
* depends_on: This ensures that the vpc object will be created before the Public Gateway Module
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
  Here the provider name is ibm and value is jp-osa
**/
module "pg_region2" {
  source            = "./modules/public_gateway"
  vpc_id            = module.vpc_region2.id
  prefix            = "${var.prefix}region-${local.region2}-"
  resource_group_id = var.resource_group_id
  zones             = var.zones[local.region2]
  depends_on        = [module.vpc_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}


/**
 * Locals
 * This resource will be used to create and calculate local variables containing Subnet IP count.
 * If there is a requirement for extra ips please update the db_ip_count with extra required ips.
 **/
locals {
  valid_ip_counts = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
  min_zones       = min(length(var.zones[local.region1]), length(var.zones[local.region2])) # takes both regions and give min number of zones and it is used to calculate the dynamic IP_count
  web_ip_count    = ceil(var.web_max_servers_count / local.min_zones) + 5 + 2               # 5:reservedIP, 2:load_balancer  
  app_ip_count    = ceil(var.app_max_servers_count / local.min_zones) + 5 + 2               # 5:reservedIP, 2:load_balancer      
  db_ip_count     = var.db_vsi_count + 5                                                    # db_vsi_count:total_db_count, 5:reservedIP

  ip_count = {
    "web" = [for valid_web_ip_count in local.valid_ip_counts : valid_web_ip_count if valid_web_ip_count > local.web_ip_count][0]
    "app" = [for valid_app_ip_count in local.valid_ip_counts : valid_app_ip_count if valid_app_ip_count > local.app_ip_count][0]
    "db"  = [for valid_db_ip_count in local.valid_ip_counts : valid_db_ip_count if valid_db_ip_count > local.db_ip_count][0]
  }
}

/**
* Calling the Subnet module for region 1 with the following required parameters
* source: Path of the Source Code of the Subnet Module
* vpc_id: VPC ID of region 1 for the the Subnet Module. Subnets will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* public_gateway_ids: List of ids of all the public gateways of region 1 where subnets will get attached
* ip_count: Total number of IP Address for each subnet
* db_vsi_count: Total Database instances that will be created in the user specified region.
* depends_on: This ensures that the vpc and public gateway objects will be created before the Subnet Module
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-tok
**/
module "subnet_region1" {
  source             = "./modules/subnet"
  vpc_id             = module.vpc_region1.id
  prefix             = "${var.prefix}region-${local.region1}-"
  resource_group_id  = var.resource_group_id
  zones              = var.zones[local.region1]
  public_gateway_ids = module.pg_region1.pg_ids
  ip_count           = local.ip_count
  db_vsi_count       = var.db_vsi_count
  depends_on         = [module.vpc_region1, module.pg_region1]
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Calling the Subnet module for region 2 with the following required parameters
* source: Path of the Source Code of the Subnet Module
* vpc_id: VPC ID of region 2 for the the Subnet Module. Subnets will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* public_gateway_ids: List of ids of all the public gateways of region 2 where subnets will get attached
* ip_count: Total number of IP Address for each subnet
* db_vsi_count: Total Database instances that will be created in the user specified region.
* depends_on: This ensures that the vpc and public gateway objects will be created before the Subnet Module
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-osa
**/
module "subnet_region2" {
  source             = "./modules/subnet"
  vpc_id             = module.vpc_region2.id
  prefix             = "${var.prefix}region-${local.region2}-"
  resource_group_id  = var.resource_group_id
  zones              = var.zones[local.region2]
  public_gateway_ids = module.pg_region2.pg_ids
  ip_count           = local.ip_count
  db_vsi_count       = var.db_vsi_count
  depends_on         = [module.vpc_region2, module.pg_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}

/**
* Calling the Security Group module for region 1 with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID of region 1 to contain the subnets.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group id
* alb_port: This is the Application load balancer listener port
* bastion1_subnet: This is the Bastion-1 subnet CIDR Range
* bastion2_subnet: This is the Bastion-2 subnet CIDR Range
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* db_region1_subnets: Region1 DB subnet CIDR range list
* db_region2_subnets: Region2 DB subnet CIDR range list
* db_vsi_count: Total Database instances that will be created in the user specified region.
* app_os_type: OS image to be used [Windows | Linux] for App Server
* web_os_type: OS image to be used [Windows | Linux] for Web Server
* db_os_type: OS image to be used [Windows | Linux] for DB Server
* depends_on: This ensures that the vpc and subnet object will be created before the security groups
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-osa
**/

module "sg_region1" {
  source             = "./modules/security_group"
  vpc_id             = module.vpc_region1.id
  prefix             = "${var.prefix}region-${local.region1}-"
  resource_group_id  = var.resource_group_id
  alb_port           = var.alb_port
  bastion1_subnet    = module.bastion_region1.bastion_subnet_cidr
  bastion2_subnet    = module.bastion_region2.bastion_subnet_cidr
  zones              = var.zones[local.region1]
  db_region1_subnets = module.subnet_region1.sub_objects["db"].*.ipv4_cidr_block
  db_region2_subnets = module.subnet_region2.sub_objects["db"].*.ipv4_cidr_block
  db_vsi_count       = var.db_vsi_count
  app_os_type        = var.app_os_type
  web_os_type        = var.web_os_type
  db_os_type         = var.db_os_type
  depends_on         = [module.vpc_region1, module.subnet_region1]
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Calling the Security Group module for region 2 with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID of region 2 to contain the subnets.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group id
* alb_port: This is the Application load balancer listener port
* bastion1_subnet: This is the Bastion-1 subnet CIDR Range
* bastion2_subnet: This is the Bastion-2 subnet CIDR Range
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* db_region1_subnets: Region1 DB subnet CIDR range list
* db_region2_subnets: Region2 DB subnet CIDR range list
* db_vsi_count: Total Database instances that will be created in the user specified region.
* app_os_type: OS image to be used [Windows | Linux] for App Server
* web_os_type: OS image to be used [Windows | Linux] for Web Server
* db_os_type: OS image to be used [Windows | Linux] for DB Server
* depends_on: This ensures that the vpc and subnet object will be created before the security groups
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
* Here the provider name is ibm and value is jp-osa
**/

module "sg_region2" {
  source             = "./modules/security_group"
  vpc_id             = module.vpc_region2.id
  prefix             = "${var.prefix}region-${local.region2}-"
  resource_group_id  = var.resource_group_id
  alb_port           = var.alb_port
  bastion1_subnet    = module.bastion_region1.bastion_subnet_cidr
  bastion2_subnet    = module.bastion_region2.bastion_subnet_cidr
  zones              = var.zones[local.region2]
  db_region1_subnets = module.subnet_region1.sub_objects["db"].*.ipv4_cidr_block
  db_region2_subnets = module.subnet_region2.sub_objects["db"].*.ipv4_cidr_block
  db_vsi_count       = var.db_vsi_count
  app_os_type        = var.app_os_type
  web_os_type        = var.web_os_type
  db_os_type         = var.db_os_type
  depends_on         = [module.vpc_region2, module.subnet_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}

/**
* Calling the Load Balancer module for region 1 with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID of region 1 to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* lb_sg: load balancer security group to be attached with all the load balancers.
* subnets: We are passing the Map of subnet objects. It includes all the subnet IDs
* alb_port: This is the Application load balancer listener port
* lb_type_private: This variable will hold the Load Balancer type as private
* lb_type_public: This variable will hold the Load Balancer type as public
* lb_protocol: lbaas Protocols
* lb_algo: lbaaS backend distribution algorithm
* lb_port_number: lbaaS pool member port number
* depends_on: This ensures that the vpc, subnet and security group object will be created before the load balancer
* providers: Name of the alias from the Providers. It will help to create a vpc for that region. Here the provider name is ibm and value is jp-tok
**/

module "load_balancer_region1" {
  source            = "./modules/load_balancer"
  vpc_id            = module.vpc_region1.id
  prefix            = "${var.prefix}region-${local.region1}-"
  resource_group_id = var.resource_group_id
  zones             = var.zones[local.region1]
  lb_sg             = module.sg_region1.sg_objects["lb"].id
  subnets           = module.subnet_region1.sub_objects
  alb_port          = var.alb_port
  lb_type_private   = var.lb_type_private
  lb_type_public    = var.lb_type_public
  lb_protocol       = var.lb_protocol
  lb_algo           = var.lb_algo
  lb_port_number    = var.lb_port_number
  depends_on        = [module.vpc_region1, module.subnet_region1, module.sg_region1]
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Calling the Load Balancer module for region 2 with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID of region 2 to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* lb_sg: load balancer security group to be attached with all the load balancers.
* subnets: We are passing the Map of subnet objects. It includes all the subnet IDs
* alb_port: This is the Application load balancer listener port
* lb_type_private: This variable will hold the Load Balancer type as private
* lb_type_public: This variable will hold the Load Balancer type as public
* lb_protocol: lbaas Protocols
* lb_algo: lbaaS backend distribution algorithm
* lb_port_number: lbaaS pool member port number
* depends_on: This ensures that the vpc, subnet and security group object will be created before the load balancer
* providers: Name of the alias from the Providers. It will help to create a vpc for that region. Here the provider name is ibm and value is jp-osa
**/

module "load_balancer_region2" {
  source            = "./modules/load_balancer"
  vpc_id            = module.vpc_region2.id
  prefix            = "${var.prefix}region-${local.region2}-"
  resource_group_id = var.resource_group_id
  zones             = var.zones[local.region2]
  lb_sg             = module.sg_region2.sg_objects["lb"].id
  subnets           = module.subnet_region2.sub_objects
  alb_port          = var.alb_port
  lb_type_private   = var.lb_type_private
  lb_type_public    = var.lb_type_public
  lb_protocol       = var.lb_protocol
  lb_algo           = var.lb_algo
  lb_port_number    = var.lb_port_number
  depends_on        = [module.vpc_region2, module.subnet_region2, module.sg_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}

/**
* Calling the Instance module for Region-1 with the following required parameters
* source: Source Directory of the Module
* prefix: This will be appended in resources created by this module
* vpc_id: VPC ID to contain the subnets for Region-1
* ssh_key: This ssh_key got generated dynamically on the bastion server and further will be attached with all the other VSI to be connected from Bastion Server only
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* bandwidth: Bandwidth per second in GB. The possible values are 3, 5 and 10
* data_vol_size: Storage size in GB. The value should be between 10 and 2000
* db_image: Image id to be used with DB VSI
* db_profile: Hardware configuration profile for the DB VSI
* db_vsi_count: Total Database instances that will be created in the user specified region.
* subnets: Subnet ID for the Database VSI
* db_sg: Security group id to be attached with DB VSI
* tiered_profiles: Tiered profiles for Input/Output per seconds in GBs
* depends_on: This ensures that the subnets, security group and bastion object will be created before the instance
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.Here the provider name is ibm and value is jp-tok
**/

module "instance_region1" {
  source            = "./modules/instance"
  prefix            = "${var.prefix}region-${local.region1}-"
  vpc_id            = module.vpc_region1.id
  ssh_key           = [module.ssh_key_data_sources_region1.bastion1_key_id_op, module.ssh_key_data_sources_region1.bastion2_key_id_op]
  resource_group_id = var.resource_group_id
  zones             = var.zones[local.region1]
  bandwidth         = var.bandwidth
  data_vol_size     = var.data_vol_size
  db_image          = var.db_image_region1
  db_profile        = var.db_profile
  db_vsi_count      = var.db_vsi_count
  subnets           = module.subnet_region1.sub_objects["db"].*.id
  db_sg             = module.sg_region1.sg_objects["db"].id
  tiered_profiles   = var.tiered_profiles
  db_pwd            = var.db_pwd
  db_user           = var.db_user
  db_name           = var.db_name
  depends_on        = [module.subnet_region1.ibm_is_subnet, module.sg_region1, module.bastion_region1, module.bastion_region2]
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Calling the Instance module for Region-2 with the following required parameters
* source: Source Directory of the Module
* prefix: This will be appended in resources created by this module
* vpc_id: VPC ID to contain the subnets for Region-2
* ssh_key: This ssh_key got generated dynamically on the bastion server and further will be attached with all the other VSI to be connected from Bastion Server only
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* bandwidth: Bandwidth per second in GB. The possible values are 3, 5 and 10
* data_vol_size: Storage size in GB. The value should be between 10 and 2000
* db_image: Image id to be used with DB VSI
* db_profile: Hardware configuration profile for the DB VSI
* db_vsi_count: Total Database instances that will be created in the user specified region.
* subnets: Subnet ID for the Database VSI
* db_sg: Security group id to be attached with DB VSI
* tiered_profiles: Tiered profiles for Input/Output per seconds in GBs
* depends_on: This ensures that the subnets, security group and bastion object will be created before the instance
* providers: Name of the alias from the Providers. It will help to create a vpc for that region.
  Here the provider name is ibm and value is jp-osa
**/

module "instance_region2" {
  source            = "./modules/instance"
  prefix            = "${var.prefix}region-${local.region2}-"
  vpc_id            = module.vpc_region2.id
  ssh_key           = [module.ssh_key_data_sources_region2.bastion2_key_id_op, module.ssh_key_data_sources_region2.bastion1_key_id_op]
  resource_group_id = var.resource_group_id
  zones             = var.zones[local.region2]
  bandwidth         = var.bandwidth
  data_vol_size     = var.data_vol_size
  db_image          = var.db_image_region2
  db_profile        = var.db_profile
  db_vsi_count      = var.db_vsi_count
  subnets           = module.subnet_region2.sub_objects["db"].*.id
  db_sg             = module.sg_region2.sg_objects["db"].id
  tiered_profiles   = var.tiered_profiles
  db_pwd            = var.db_pwd
  db_user           = var.db_user
  db_name           = var.db_name
  depends_on        = [module.subnet_region2.ibm_is_subnet, module.sg_region2, module.bastion_region1, module.bastion_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}

/**
* Calling the Instance Group module for Region 1 with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets for Region 1
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* ssh_key: This ssh_key got generated dynamically on the bastion server and further will be attached with all the other VSI to be connected from Bastion Server only
* subnets: We are passing the Map of subnet objects. It includes all the subnet IDs
* sg_objects: We are passing the Map of security group objects. It includes all the security groups IDs
* objects: This variable will contain the objects of LB, LB Pool and LB Listeners. It includes IDs of load balancer, load balancer pools and load balancer listeners.
* app_config: Application configuration Map
* web_config: Web configuration Map
* app_image: Image id to be used with App VSI
* web_image: Image id to be used with Web VSI
* web_max_servers_count: Maximum Web servers count for the Web Instance group
* web_min_servers_count: Minimum Web servers count for the Web Instance group
* web_cpu_threshold: Average target CPU Percent for CPU policy of Web Instance Group.
* app_max_servers_count: Maximum App servers count for the App Instance group
* app_min_servers_count: Minimum App servers count for the App Instance group
* app_cpu_threshold: Average target CPU Percent for CPU policy of App Instance Group.
* web_aggregation_window: The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization.
* app_aggregation_window: The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization.
* web_cooldown_time: Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place.
* app_cooldown_time: Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place.
* depends_on: This ensures that the vpc and other objects will be created before the instance group
* providers: Name of the alias from the Providers. It will help to create a vpc for that region. 
* Here the provider name is ibm and value is jp-tok
**/

module "instance_group_region1" {
  source                 = "./modules/instance_group"
  prefix                 = "${var.prefix}region-${local.region1}-"
  vpc_id                 = module.vpc_region1.id
  resource_group_id      = var.resource_group_id
  zones                  = var.zones[local.region1]
  ssh_key                = [module.ssh_key_data_sources_region1.bastion1_key_id_op, module.ssh_key_data_sources_region1.bastion2_key_id_op]
  subnets                = module.subnet_region1.sub_objects
  sg_objects             = module.sg_region1.sg_objects
  objects                = module.load_balancer_region1.objects
  app_config             = var.app_config
  app_image              = var.app_image_region1
  web_config             = var.web_config
  web_image              = var.web_image_region1
  web_max_servers_count  = var.web_max_servers_count
  web_min_servers_count  = var.web_min_servers_count
  web_cpu_threshold      = var.web_cpu_threshold
  app_max_servers_count  = var.app_max_servers_count
  app_min_servers_count  = var.app_min_servers_count
  app_cpu_threshold      = var.app_cpu_threshold
  web_aggregation_window = var.web_aggregation_window
  app_aggregation_window = var.app_aggregation_window
  web_cooldown_time      = var.web_cooldown_time
  app_cooldown_time      = var.app_cooldown_time
  db_private_ip          = module.instance_region1.db_target[0]
  db_pwd                 = var.db_pwd
  db_user                = var.db_user
  db_name                = var.db_name
  web_lb_hostname        = module.load_balancer_region1.lb_dns.WEB_SERVER
  wp_blog_title          = var.wp_blog_title
  wp_admin_user          = var.wp_admin_user
  wp_admin_password      = var.wp_admin_password
  wp_admin_email         = var.wp_admin_email
  depends_on             = [module.bastion_region1, module.bastion_region2, module.load_balancer_region1]
  providers = {
    ibm = ibm.jp-tok
  }
}

/**
* Calling the Instance Group module for Region 2 with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets for Region 2
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is jp-tok then zones would be ["jp-tok-1","jp-tok-2","jp-tok-3"]
* ssh_key: This ssh_key got generated dynamically on the bastion server and further will be attached with all the other VSI to be connected from Bastion Server only
* subnets: We are passing the Map of subnet objects. It includes all the subnet IDs
* sg_objects: We are passing the Map of security group objects. It includes all the security groups IDs
* objects: This variable will contain the objects of LB, LB Pool and LB Listeners. It includes IDs of load balancer, load balancer pools and load balancer listeners.
* app_config: Application configuration Map
* web_config: Web configuration Map
* app_image: Image id to be used with App VSI
* web_image: Image id to be used with Web VSI
* web_max_servers_count: Maximum Web servers count for the Web Instance group
* web_min_servers_count: Minimum Web servers count for the Web Instance group
* web_cpu_threshold: Average target CPU Percent for CPU policy of Web Instance Group.
* app_max_servers_count: Maximum App servers count for the App Instance group
* app_min_servers_count: Minimum App servers count for the App Instance group
* app_cpu_threshold: Average target CPU Percent for CPU policy of App Instance Group.
* web_aggregation_window: The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization.
* app_aggregation_window: The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization.
* web_cooldown_time: Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place.
* app_cooldown_time: Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place.
* depends_on: This ensures that the vpc and other objects will be created before the instance group
* providers: Name of the alias from the Providers. It will help to create a vpc for that region. 
* Here the provider name is ibm and value is jp-osa
**/

module "instance_group_region2" {
  source                 = "./modules/instance_group"
  prefix                 = "${var.prefix}region-${local.region2}-"
  vpc_id                 = module.vpc_region2.id
  resource_group_id      = var.resource_group_id
  zones                  = var.zones[local.region2]
  ssh_key                = [module.ssh_key_data_sources_region2.bastion2_key_id_op, module.ssh_key_data_sources_region2.bastion1_key_id_op]
  subnets                = module.subnet_region2.sub_objects
  sg_objects             = module.sg_region2.sg_objects
  objects                = module.load_balancer_region2.objects
  app_config             = var.app_config
  app_image              = var.app_image_region2
  web_config             = var.web_config
  web_image              = var.web_image_region2
  web_max_servers_count  = var.web_max_servers_count
  web_min_servers_count  = var.web_min_servers_count
  web_cpu_threshold      = var.web_cpu_threshold
  app_max_servers_count  = var.app_max_servers_count
  app_min_servers_count  = var.app_min_servers_count
  app_cpu_threshold      = var.app_cpu_threshold
  web_aggregation_window = var.web_aggregation_window
  app_aggregation_window = var.app_aggregation_window
  web_cooldown_time      = var.web_cooldown_time
  app_cooldown_time      = var.app_cooldown_time
  db_private_ip          = module.instance_region2.db_target[0]
  db_pwd                 = var.db_pwd
  db_user                = var.db_user
  db_name                = var.db_name
  web_lb_hostname        = module.load_balancer_region2.lb_dns.WEB_SERVER
  wp_blog_title          = var.wp_blog_title
  wp_admin_user          = var.wp_admin_user
  wp_admin_password      = var.wp_admin_password
  wp_admin_email         = var.wp_admin_email
  depends_on             = [module.bastion_region1, module.bastion_region2, module.load_balancer_region2]
  providers = {
    ibm = ibm.jp-osa
  }
}


/**
* Calling the global_load_balancer module with the following required parameters
* source: Path of the Source Code of the Transit Gateway Module
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* region1: Providing the region name of region1 loadbalancer
* region2: Providing the region name of region2 loadbalancer
* glb_domain_name: Providing the domain name with which we want to create global loadbalancer
* glb_traffic_steering: GLB traffic Steering Policy which allows off,geo,random,dynamic_latency
* glb_region1_code: Enter the Region code for GLB Geo Routing for Region 1 Pool
* glb_region2_code: Enter the Region code for GLB Geo Routing for Region 2 Pool
* cis_glb_plan: Plan to be used for CIS instance for GLB
* cis_glb_location: Location to be used for CIS instance for GLB
* glb_proxy_enabled: Global loadbalancer proxy state
* expected_body: A case-insensitive sub-string to look for in the response body. If this string is not found, the origin will be marked as unhealthy. 
*                A null value of "" is allowed to match on any content
* expected_codes: The expected HTTP response code or code range of the health check
* glb_healthcheck_method: Method to be used for GLB health check
* glb_healthcheck_timeout: The timeout in seconds before marking the health check as failed
* glb_healthcheck_path: The endpoint path to health check against
* allow_insecure: If set to true, the certificate is not validated when the health check uses HTTPS. If set to false, the certificate is validated, even if the health check uses HTTPS. The default value is false.
* region1_pool_weight: The origin pool-1 weight.
* region2_pool_weight: The origin pool-2 weight.
* glb_protocol_type: The protocol to use for the health check
* interval: The interval between each health check. Shorter intervals may improve failover time, 
*           but will increase load on the origins as we check from multiple locations
* retries: The number of retries to attempt in case of a timeout before marking the origin as unhealthy
* follow_redirects: If set to true, a redirect is followed when a redirect is returned by the origin pool. Is set to false, redirects from the origin pool are not followed
* glb_healthcheck_port: The TCP port number that you want to use for the health check
* minimum_origins: The minimum number of origins that must be healthy for the pool to serve traffic. If the number of healthy origins falls within this number, 
*                  the pool will be marked unhealthy and we will failover to the next available pool
* notification_email: The Email address to send health status notifications to. This can be an individual mailbox or a mailing list.
* web_lb_ip_region1: We are passing the public IP of WEb Loadbalancer of Region 1
* web_lb_ip_region2: We are passing the public IP of WEb Loadbalancer of Region 2
* depends_on: This ensures that the loadbalancers will be created before the global loadbalancer
**/

module "global_load_balancer" {
  source                  = "./modules/global_load_balancer"
  prefix                  = var.prefix
  resource_group_id       = var.resource_group_id
  region1                 = local.region1
  region2                 = local.region2
  glb_domain_name         = var.glb_domain_name
  glb_traffic_steering    = var.glb_traffic_steering
  glb_region1_code        = var.glb_region1_code
  glb_region2_code        = var.glb_region2_code
  cis_glb_plan            = var.cis_glb_plan
  cis_glb_location        = var.cis_glb_location
  glb_proxy_enabled       = var.glb_proxy_enabled
  expected_body           = var.expected_body
  expected_codes          = var.expected_codes
  glb_healthcheck_method  = var.glb_healthcheck_method
  glb_healthcheck_timeout = var.glb_healthcheck_timeout
  glb_healthcheck_path    = var.glb_healthcheck_path
  glb_protocol_type       = var.glb_protocol_type
  interval                = var.interval
  retries                 = var.retries
  follow_redirects        = var.follow_redirects
  glb_healthcheck_port    = var.glb_healthcheck_port
  allow_insecure          = var.allow_insecure
  minimum_origins         = var.minimum_origins
  region1_pool_weight     = var.region1_pool_weight
  region2_pool_weight     = var.region2_pool_weight
  notification_email      = var.notification_email
  web_lb_ip_region1       = module.load_balancer_region1.lb_public_ip["WEB_SERVER"][0]
  web_lb_ip_region2       = module.load_balancer_region2.lb_public_ip["WEB_SERVER"][0]
  depends_on              = [module.load_balancer_region1, module.load_balancer_region2]
}
