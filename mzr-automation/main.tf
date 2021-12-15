/**
----------------------------------------------------------------|
* Total Resource Count for the default value of this project:   |
----------------------------------------------------------------|
* VPC Count                     = 1
* Public Gateway                = 3
* Subnet Count                  = 9
* Security Group Count          = 5
* Security Group Rules          = 17
* Load Balancers                = 2
* Load Balancer Listener        = 2
* Load Balancer Pool            = 2
* Bastion VSI                   = 1
* Instance Template             = 2
* Instance Group                = 2
* Instance Group Manager        = 2
* Instance Group Policy         = 8
* Database VSI                  = 2
* Time Sleep                    = 1
* Data Volume                   = 2
* Null Resource                 = 1
* Data Source Auth Token        = 1
* Data Source ssh_key           = 1
* Dynamic ssh_key               = 1
* IKE Policy                    = 1
* IPSec Policy                  = 1
* VPN Gateway                   = 1
* VPN Gateway Connection        = 1
* VPC Routing Table             = 1
* VPC Routing Table Route       = 1
*--------------------------------------|
*--------------------------------------|
* Total Resources               = 72   |
*--------------------------------------|
*--------------------------------------|
**/


/**
* Calling the VPC module with the following required parameters
* source: Path of the Source Code of the VPC Module
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
**/

module "vpc" {
  source            = "./modules/vpc"
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
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
* prefix: This will be appended in resources created by this module
* vpc_id: VPC ID to contain the subnets
* user_ssh_key: This is the name of an existing ssh key of user which will be used to login to Bastion server. Its private key content should be there in path ~/.ssh/id_rsa 
    And public key content should be uploaded to IBM cloud. If you don't have an existing key then create one using ssh-keygen -t rsa -b 4096 -C "user_ID" command.
* bastion_ssh_key: This key will be created dynamically on the bastion VSI. It will be used to login to Web/App/DB servers via Bastion.
* my_public_ip: User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* api_key: Api key of user which will be used to login to IBM cloud in provisioner section
* region: User specified Region code
* bastion_profile: The Profile needed for Bastion VSI creation
* bastion_os_type: OS image to be used [windows | linux] for Bastion server
* local_machine_os_type: Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply
* bastion_image: The Bastion Image needed for Bastion VSI creation
* bastion_ip_count: IP count is the total number of total_ipv4_address_count for Bastion Subnet
* depends_on: This ensures that the subnet and security group object will be created before the bastion
**/

module "bastion" {
  source                = "./modules/bastion"
  prefix                = var.prefix
  vpc_id                = module.vpc.id
  user_ssh_key          = [data.ibm_is_ssh_key.ssh_key_id.id]
  bastion_ssh_key       = var.bastion_ssh_key_var_name
  my_public_ip          = var.my_public_ip
  resource_group_id     = var.resource_group_id
  zones                 = var.zones[var.region]
  api_key               = var.api_key
  region                = var.region
  bastion_profile       = var.bastion_profile
  bastion_os_type       = var.bastion_os_type
  local_machine_os_type = var.local_machine_os_type
  bastion_image         = var.bastion_image
  bastion_ip_count      = var.bastion_ip_count
  vpn_routing_table_id  = module.vpn.routing_table_id
  public_gateway_ids    = module.public_gateway.pg_ids
  vpn_mode              = var.vpn_mode
  depends_on            = [module.vpc]
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
* Calling the Public Gateway module with the following required parameters
* source: Path of the Source Code of the Public Gateway Module
* vpc_id: VPC ID for the the Public Gateway Module. Public Gateways will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is us-east then zones would be ["us-east-1","us-east-2","us-east-3"]
* depends_on: This ensures that the vpc object will be created before the Public Gateway Module
**/
module "public_gateway" {
  source            = "./modules/public_gateway"
  vpc_id            = module.vpc.id
  prefix            = "${var.prefix}region-"
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  depends_on        = [module.vpc]
}

/**
* Locals
* This resource will be used to create and calculate local variables containing Subnet IP count.
* If there is a requirement for extra ips please update the db_ip_count with extra required ips.
**/
locals {
  valid_ip_counts = [8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384]
  web_ip_count    = ceil(var.web_max_servers_count / length(var.zones[var.region])) + 5 + 2 # 5:reservedIP, 2:load_balancer  
  app_ip_count    = ceil(var.app_max_servers_count / length(var.zones[var.region])) + 5 + 2 # 5:reservedIP, 2:load_balancer      
  db_ip_count     = 2 + 5                                                                   # 2:total_db_count # 5:reservedIP 

  ip_count = {
    "web" = [for valid_web_ip_count in local.valid_ip_counts : valid_web_ip_count if valid_web_ip_count > local.web_ip_count][0]
    "app" = [for valid_app_ip_count in local.valid_ip_counts : valid_app_ip_count if valid_app_ip_count > local.app_ip_count][0]
    "db"  = [for valid_db_ip_count in local.valid_ip_counts : valid_db_ip_count if valid_db_ip_count > local.db_ip_count][0]
  }
}

/**
* Calling the Subnet module with the following required parameters
* source: Path of the Source Code of the Subnet Module
* vpc_id: VPC ID for the the Subnet Module. Subnets will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* resource_group_id: The resource group ID
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* ip_count: Total number of IP Address for each subnet
* public_gateway_ids: List of ids of all the public gateways of region 1 where subnets will get attached
* depends_on: This ensures that the vpc object will be created before the Subnet Module
**/
module "subnet" {
  source             = "./modules/subnet"
  vpc_id             = module.vpc.id
  prefix             = var.prefix
  resource_group_id  = var.resource_group_id
  zones              = var.zones[var.region]
  ip_count           = local.ip_count
  public_gateway_ids = module.public_gateway.pg_ids
  depends_on         = [module.vpc]
}

/**
* Calling the Security Group module with the following required parameters
* source: Source Directory of the Module
* vpc_id: VPC ID to contain the subnets
* prefix: This will be appended in resources created by this module
* resource_group_id: The resource group id
* my_public_ip: User's Public IP address which will be used to login to Bastion VSI from their local machine
* alb_port: This is the Application load balancer listener port
* app_os_type: Provide App servers OS flavour
* web_os_type: Provide Web servers OS flavour
* db_os_type: Provide Db servers OS flavour
* depends_on: This ensures that the vpc and subnet object will be created before the security groups
**/

module "security_group" {
  source            = "./modules/security_group"
  vpc_id            = module.vpc.id
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  my_public_ip      = var.my_public_ip
  alb_port          = var.alb_port
  bastion_sg        = module.bastion.bastion_sg
  app_os_type       = var.app_os_type
  web_os_type       = var.web_os_type
  db_os_type        = var.db_os_type
  depends_on        = [module.vpc, module.subnet]
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
* lb_type_private: This variable will hold the Load Balancer type as private
* lb_type_public: This variable will hold the Load Balancer type as public
* lb_protocol: lbaaS protocols
* lb_algo: lbaaS backend distribution algorithm
* lb_port_number: declare lbaaS pool member port number
* depends_on: This ensures that the vpc, subnet and security group object will be created before the load balancer
**/

module "load_balancer" {
  source            = "./modules/load_balancer"
  vpc_id            = module.vpc.id
  prefix            = var.prefix
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  lb_sg             = module.security_group.sg_objects["lb"].id
  subnets           = module.subnet.sub_objects
  alb_port          = var.alb_port
  lb_type_private   = var.lb_type_private
  lb_type_public    = var.lb_type_public
  lb_protocol       = var.lb_protocol
  lb_algo           = var.lb_algo
  lb_port_number    = var.lb_port_number
  depends_on        = [module.vpc, module.subnet, module.security_group]
}

/**
* Calling the Instance module with the following required parameters
* source: Source Directory of the Module
* prefix: This will be appended in resources created by this module
* vpc_id: VPC ID to contain the subnets
* ssh_key: This ssh_key got generated dynamically on the bastion server and further will be attached with all the other VSI to be connected from Bastion Server only
* resource_group_id: The resource group id
* zones: List of zones for the provided region. If region is us-south then zones would be ["us-south-1","us-south-2","us-south-3"]
* bandwidth: Bandwidth per second in GB. The possible values are 3, 5 and 10
* data_vol_size: Storage size in GB. The value should be between 10 and 2000
* db_image: Image id to be used with DB VSI
* db_profile: Hardware configuration profile for the DB VSI
* tiered_profiles: Tiered profiles for Input/Output per seconds in GBs
* subnets: Subnet ID for the Database VSI
* db_sg: Security group id to be attached with DB VSI
* depends_on: This ensures that the subnets, security group and bastion object will be created before the instance
**/

module "instance" {
  source            = "./modules/instance"
  prefix            = var.prefix
  vpc_id            = module.vpc.id
  ssh_key           = [data.ibm_is_ssh_key.bastion_key_id.id]
  resource_group_id = var.resource_group_id
  zones             = var.zones[var.region]
  bandwidth         = var.bandwidth
  data_vol_size     = var.data_vol_size
  db_image          = var.db_image
  db_profile        = var.db_profile
  tiered_profiles   = var.tiered_profiles
  subnets           = module.subnet.sub_objects["db"].*.id
  db_sg             = module.security_group.sg_objects["db"].id
  db_pwd            = var.db_pwd
  db_user           = var.db_user
  db_name           = var.db_name
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
* app_image: Image id to be used with App VSI
* app_config: Application configuration Map
* app_os_type: Provide App OS flavour
* web_os_type: Provide DB OS flavour
* web_image: Image id to be used with Web VSI
* web_config: Web configuration Map
* web_max_servers_count: Maximum Web servers count for the Web Instance group
* web_min_servers_count: Minimum Web servers count for the Web Instance group
* web_cpu_threshold: Average target CPU Percent for CPU policy of Web Instance Group.
* web_aggregation_window: The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization.
* web_cooldown_time: Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place.
* app_max_servers_count: Maximum App servers count for the App Instance group
* app_min_servers_count: Minimum App servers count for the App Instance group
* app_cpu_threshold: Average target CPU Percent for CPU policy of App Instance Group.
* app_aggregation_window: The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization.
* app_cooldown_time: Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place.
* depends_on: This ensures that the vpc and other objects will be created before the instance group
**/

module "instance_group" {
  source                 = "./modules/instance_group"
  vpc_id                 = module.vpc.id
  prefix                 = var.prefix
  resource_group_id      = var.resource_group_id
  zones                  = var.zones[var.region]
  ssh_key                = [data.ibm_is_ssh_key.bastion_key_id.id]
  subnets                = module.subnet.sub_objects
  sg_objects             = module.security_group.sg_objects
  objects                = module.load_balancer.objects
  app_image              = var.app_image
  app_config             = var.app_config
  web_image              = var.web_image
  web_config             = var.web_config
  web_max_servers_count  = var.web_max_servers_count
  web_min_servers_count  = var.web_min_servers_count
  web_cpu_threshold      = var.web_cpu_threshold
  web_aggregation_window = var.web_aggregation_window
  web_cooldown_time      = var.web_cooldown_time
  app_max_servers_count  = var.app_max_servers_count
  app_min_servers_count  = var.app_min_servers_count
  app_cpu_threshold      = var.app_cpu_threshold
  app_aggregation_window = var.app_aggregation_window
  app_cooldown_time      = var.app_cooldown_time
  db_private_ip          = module.instance.db_target[0]
  db_pwd                 = var.db_pwd
  db_user                = var.db_user
  db_name                = var.db_name
  depends_on             = [module.bastion, module.load_balancer]
}

/**
* Calling the VPN module with the following required parameters
* source: Path of the Source Code of the VPN Module
* resource_group_id: The resource group ID
* vpc_id: VPC ID for the the VPN Module. Routing table will be created inside this VPC.
* prefix: This is the prefix text that will be pre-pended in every resource name created by this module.
* zones: List of zones for the provided region. If region is us-east then zones would be ["us-east-1","us-east-2","us-east-3"]
* vpn_mode: Mode in VPN gateway. Supported values are route or policy.
* subnet: Subnet ID for the the VPN Module. VPN gateway will be created inside this Subnet.
* preshared_key: he Key configured on the peer gateway. The key is usually a complex string similar to a password.
* local_cidrs: List of local CIDRs for the creation of VPN connection.
* peer_cidrs: List of peer CIDRs for the creation of VPN connection.
* peer_gateway_ip: The IP address of the peer VPN gateway.
* action: Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none.
* admin_state_up: The VPN gateway connection status. If set to false, the VPN gateway connection is shut down
* interval: Dead peer detection interval in seconds. How often to test that the peer gateway is responsive.
* timeout: Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1.
* authentication_algorithm: Enter the algorithm that you want to use to authenticate IPSec peers. Available options are md5, sha1, sha256, or sha512
* encryption_algorithm: Enter the algorithm that you want to use to encrypt data. Available options are: triple_des, aes128, or aes256
* key_lifetime: The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated.
* dh_group: Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 2, 5, 14, or 19
* ike_version: Enter the IKE protocol version that you want to use. Available options are 1, or 2
* perfect_forward_secrecy: Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group_2, group_5, and group_14
* tags: A list of tags that you want to add to your VPN gateway. Tags can help you find your VPN gateway more easily later.
**/

module "vpn" {
  source                   = "./modules/vpn"
  prefix                   = var.prefix
  resource_group_id        = var.resource_group_id
  vpc_id                   = module.vpc.id
  zones                    = var.zones[var.region]
  vpn_mode                 = var.vpn_mode
  subnet                   = module.bastion.bastion_subnet.id
  preshared_key            = var.preshared_key
  local_cidrs              = [module.bastion.bastion_subnet.ipv4_cidr_block]
  peer_cidrs               = var.peer_cidrs
  peer_gateway_ip          = var.peer_gateway_ip
  action                   = var.action
  admin_state_up           = var.admin_state_up
  interval                 = var.interval
  timeout                  = var.timeout
  authentication_algorithm = var.authentication_algorithm
  encryption_algorithm     = var.encryption_algorithm
  key_lifetime             = var.key_lifetime
  dh_group                 = var.dh_group
  ike_version              = var.ike_version
  perfect_forward_secrecy  = var.perfect_forward_secrecy
  tags                     = [var.prefix]
}

/**
* Time Sleep
* Element : wait_600_seconds_app
* This resource will create a waiting period so the respective IG servers are up and running.
**/
resource "time_sleep" "wait_600_seconds_app" {
  depends_on      = [module.instance_group]
  create_duration = "600s"
}
