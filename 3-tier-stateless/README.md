# Overview
This use case builds the following in a single MZR.  A single VSI is created across 3 different zones
and for each tier, totally 9 VSIs, and in their respective subnets and security groups. In addition,
another VSI, bastion server, is created for VSIs access and management.  Load balancers are created for
each tier to help distribute incoming requests.

**Note:** You change the VSI count to increase the number of total VSIs for the application which also may
mean increasing the subnet count. Pluse you will also need to modify the security groups and load balancers
policies to match your application requirements.

* Resource Count for this project:
* VPC Count                     = 1
* Subnet Count                  = 9
* Security Group Count          = 5
* Security Group Rules          = 15
* Load Balancers                = 2
* Load Balancer Listener        = 2
* Load Balancer Pool            = 2
* Load Balancer Pool Member     = 6
* Bastion VSI                   = 1
* Web VSI                       = 3
* App VSI                       = 3
* Database VSI                  = 2
* Time Sleep                    = 1
* Floating IP                   = 1
* Null Resource                 = 1
* Data Source ssh_key           = 1
* Data Source Auth Token        = 1
* Dynamic ssh_key               = 1
* Public Gateway                = 3

<img src="./images/3-tier-app-MZR_v3.jpg"/>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.39.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.39.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion | n/a |
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/instance | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancer | n/a |
| <a name="module_public_gateway"></a> [public\_gateway](#module\_public\_gateway) | ./modules/public_gateway | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security_group | n/a |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnet | n/a |

## Resources

| Name | Type |
|------|------|
| [ibm_is_vpc.vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.39.1/docs/resources/is_vpc) | resource |
| [ibm_is_ssh_key.bastion_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.39.1/docs/data-sources/is_ssh_key) | data source |
| [ibm_is_ssh_key.ssh_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.39.1/docs/data-sources/is_ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | This is the Application load balancer listener port | `number` | `80` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Please enter the IBM Cloud API key. | `string` | n/a | yes |
| <a name="input_app_image"></a> [app\_image](#input\_app\_image) | This variable will hold the image name for app instance | `string` | n/a | yes |
| <a name="input_app_os_type"></a> [app\_os\_type](#input\_app\_os\_type) | OS image to be used is linux for App Server | `string` | n/a | yes |
| <a name="input_app_profile"></a> [app\_profile](#input\_app\_profile) | This variable will hold the image profile name for app instance | `string` | `"cx2-2x4"` | no |
| <a name="input_bastion_image"></a> [bastion\_image](#input\_bastion\_image) | Specify Image to be used with Bastion VSI | `string` | n/a | yes |
| <a name="input_bastion_ip_count"></a> [bastion\_ip\_count](#input\_bastion\_ip\_count) | IP count is the total number of total\_ipv4\_address\_count for Bastion Subnet | `number` | `8` | no |
| <a name="input_bastion_os_type"></a> [bastion\_os\_type](#input\_bastion\_os\_type) | OS image to be used linux for Bastion server | `string` | n/a | yes |
| <a name="input_bastion_profile"></a> [bastion\_profile](#input\_bastion\_profile) | Specify the profile needed for Bastion VSI | `string` | `"cx2-2x4"` | no |
| <a name="input_bastion_ssh_key_var_name"></a> [bastion\_ssh\_key\_var\_name](#input\_bastion\_ssh\_key\_var\_name) | This is the name of the ssh key which will be generated dynamically on the bastion server and further will be attached with all the other Web/App/DB servers. It will be used to login to Web/App/DB servers via Bastion server only. | `string` | `"bastion-ssh-key"` | no |
| <a name="input_db_image"></a> [db\_image](#input\_db\_image) | This variable will hold the image name for db instance | `string` | n/a | yes |
| <a name="input_db_os_type"></a> [db\_os\_type](#input\_db\_os\_type) | OS image to be used is linux for DB Server | `string` | n/a | yes |
| <a name="input_db_profile"></a> [db\_profile](#input\_db\_profile) | This variable will hold the image profile name for db instance | `string` | `"cx2-2x4"` | no |
| <a name="input_db_vsi_count"></a> [db\_vsi\_count](#input\_db\_vsi\_count) | Total Database instances that will be created in the user specified region. | `number` | `2` | no |
| <a name="input_lb_algo"></a> [lb\_algo](#input\_lb\_algo) | lbaaS backend distribution algorithm | `map(any)` | <pre>{<br>  "least-x": "least_connections",<br>  "rr": "round_robin",<br>  "wrr": "weighted_round_robin"<br>}</pre> | no |
| <a name="input_lb_port_number"></a> [lb\_port\_number](#input\_lb\_port\_number) | declare lbaaS pool member port numbert | `map(any)` | <pre>{<br>  "custom": "xxx",<br>  "http": "80",<br>  "https": "443"<br>}</pre> | no |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | lbaaS protocols | `map(any)` | <pre>{<br>  "443": "https",<br>  "80": "http",<br>  "l4-tcp": "tcp"<br>}</pre> | no |
| <a name="input_local_machine_os_type"></a> [local\_machine\_os\_type](#input\_local\_machine\_os\_type) | Operating System to be used [windows \| mac \| linux] for your local machine which is running terraform apply | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this script. | `string` | n/a | yes |
| <a name="input_public_ip_address_list"></a> [public\_ip\_address\_list](#input\_public\_ip\_address\_list) | Provide the User's Public IP address in the format X.X.X.X/32 which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply | `list(any)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Please enter a region from the following available region and zones mapping: <br>us-south<br>us-east<br>eu-gb<br>eu-de<br>jp-tok<br>au-syd | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID | `string` | n/a | yes |
| <a name="input_total_instance"></a> [total\_instance](#input\_total\_instance) | Total instances that will be created per zones per tier. | `number` | `1` | no |
| <a name="input_user_ssh_key"></a> [user\_ssh\_key](#input\_user\_ssh\_key) | Enter the list of IBM cloud ssh key name. | `list(string)` | n/a | yes |
| <a name="input_web_image"></a> [web\_image](#input\_web\_image) | This variable will hold the image name for web instance | `string` | n/a | yes |
| <a name="input_web_os_type"></a> [web\_os\_type](#input\_web\_os\_type) | OS image to be used is linux for Web Server | `string` | n/a | yes |
| <a name="input_web_profile"></a> [web\_profile](#input\_web\_profile) | This variable will hold the image profile name for web instance | `string` | `"cx2-2x4"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Region and zones mapping | `map(any)` | <pre>{<br>  "au-syd": [<br>    "au-syd-1",<br>    "au-syd-2",<br>    "au-syd-3"<br>  ],<br>  "br-sao": [<br>    "br-sao-1",<br>    "br-sao-2",<br>    "br-sao-3"<br>  ],<br>  "ca-tor": [<br>    "ca-tor-1",<br>    "ca-tor-2",<br>    "ca-tor-3"<br>  ],<br>  "eu-de": [<br>    "eu-de-1",<br>    "eu-de-2",<br>    "eu-de-3"<br>  ],<br>  "eu-gb": [<br>    "eu-gb-1",<br>    "eu-gb-2",<br>    "eu-gb-3"<br>  ],<br>  "jp-osa": [<br>    "jp-osa-1",<br>    "jp-osa-2",<br>    "jp-osa-3"<br>  ],<br>  "jp-tok": [<br>    "jp-tok-1",<br>    "jp-tok-2",<br>    "jp-tok-3"<br>  ],<br>  "us-east": [<br>    "us-east-1",<br>    "us-east-2",<br>    "us-east-3"<br>  ],<br>  "us-south": [<br>    "us-south-1",<br>    "us-south-2",<br>    "us-south-3"<br>  ]<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_LOAD_BALANCER"></a> [LOAD\_BALANCER](#output\_LOAD\_BALANCER) | This variable will display the private and public IP addresses and DNS of load balancers |
| <a name="output_VSI"></a> [VSI](#output\_VSI) | This variable will display the private IP address of DB servers and the public IP address of Bastion Server |
