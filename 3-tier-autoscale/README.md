# Overview
This 3-tier application use cases incorporates a compute feature, autoscale for the first and second tier VSIs.
Autoscale helps the VSI to scale horizontally (up or down) based on VSIs' resources demands.

<img src="./images/3-tier-app-with-autoscale-MZR.jpg"/>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion |  |
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/instance |  |
| <a name="module_instance_group"></a> [instance\_group](#module\_instance\_group) | ./modules/instance_groups |  |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancers |  |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security_groups |  |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnets |  |

## Resources

| Name | Type |
|------|------|
| [ibm_is_vpc.vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_vpc) | resource |
| [ibm_is_ssh_key.ssh_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/data-sources/is_ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | This is the Application load balancer listener port | `number` | `"80"` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Please enter the IBM Cloud API key. | `string` | n/a | yes |
| <a name="input_app_config"></a> [app\_config](#input\_app\_config) | Application Configurations to be passed for App Instance Group creation | `map(any)` | <pre>{<br>  "application_port": "80",<br>  "instance_image": "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8",<br>  "instance_profile": "cx2-2x4",<br>  "memory_percent": "40",<br>  "network_in": "40",<br>  "network_out": "40"<br>}</pre> | no |
| <a name="input_app_cpu_percent"></a> [app\_cpu\_percent](#input\_app\_cpu\_percent) | Average target CPU Percent for CPU policy of App Instance Group | `number` | n/a | yes |
| <a name="input_app_max_servers_count"></a> [app\_max\_servers\_count](#input\_app\_max\_servers\_count) | Maximum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_app_min_servers_count"></a> [app\_min\_servers\_count](#input\_app\_min\_servers\_count) | Minimum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Bandwidth per second in GB. The possible values are 3, 5 and 10 | `number` | n/a | yes |
| <a name="input_bastion_profile"></a> [bastion\_profile](#input\_bastion\_profile) | Specify the profile needed for Bastion VSI | `string` | `"cx2-2x4"` | no |
| <a name="input_bastion_ssh_key_var_name"></a> [bastion\_ssh\_key\_var\_name](#input\_bastion\_ssh\_key\_var\_name) | This is the name of the ssh key which will be generated dynamically on the bastion server and further will be attached with all the other Web/App/DB servers. It will be used to login to Web/App/DB servers via Bastion server only. | `string` | `"bastion-ssh-key"` | no |
| <a name="input_db_image"></a> [db\_image](#input\_db\_image) | Custom image id for the Database VSI | `string` | `"r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"` | no |
| <a name="input_db_profile"></a> [db\_profile](#input\_db\_profile) | Hardware configuration profile for the Database VSI. | `string` | `"cx2-2x4"` | no |
| <a name="input_dlb_port"></a> [dlb\_port](#input\_dlb\_port) | This is the DB load balancer listener port | `number` | `"80"` | no |
| <a name="input_ip_count"></a> [ip\_count](#input\_ip\_count) | Enter total number of IP Address for each subnet | `number` | `32` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this script. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Please enter a region from the following available region and zones mapping: <br>us-south<br>us-east<br>eu-gb<br>eu-de<br>jp-tok<br>au-syd | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Storage size in GB. The value should be between 10 and 2000 | `number` | `"10"` | no |
| <a name="input_total_instance"></a> [total\_instance](#input\_total\_instance) | Total instances that will be created per zones per tier. | `number` | `1` | no |
| <a name="input_user_ip_address"></a> [user\_ip\_address](#input\_user\_ip\_address) | Provide the User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply | `string` | n/a | yes |
| <a name="input_user_ssh_key"></a> [user\_ssh\_key](#input\_user\_ssh\_key) | This is the existing ssh key on the User's machine and will be attached with the bastion server only. This will ensure the incoming connection on Bastion Server only from the users provided ssh\_keys. You can check your key name in IBM cloud. Whose private key content should be there in path ~/.ssh/id\_rsa | `string` | n/a | yes |
| <a name="input_web_config"></a> [web\_config](#input\_web\_config) | Web Configurations to be passed for Web Instance Group creation | `map(any)` | <pre>{<br>  "application_port": "80",<br>  "instance_image": "r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8",<br>  "instance_profile": "cx2-2x4",<br>  "memory_percent": "40",<br>  "network_in": "40",<br>  "network_out": "40"<br>}</pre> | no |
| <a name="input_web_cpu_percent"></a> [web\_cpu\_percent](#input\_web\_cpu\_percent) | Average target CPU Percent for CPU policy of Web Instance Group | `number` | n/a | yes |
| <a name="input_web_max_servers_count"></a> [web\_max\_servers\_count](#input\_web\_max\_servers\_count) | Maximum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_web_min_servers_count"></a> [web\_min\_servers\_count](#input\_web\_min\_servers\_count) | Minimum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | Region and zones mapping | `map(any)` | <pre>{<br>  "au-syd": [<br>    "au-syd-1",<br>    "au-syd-2",<br>    "au-syd-3"<br>  ],<br>  "eu-de": [<br>    "eu-de-1",<br>    "eu-de-2",<br>    "eu-de-3"<br>  ],<br>  "eu-gb": [<br>    "eu-gb-1",<br>    "eu-gb-2",<br>    "eu-gb-3"<br>  ],<br>  "jp-tok": [<br>    "jp-tok-1",<br>    "jp-tok-2",<br>    "jp-tok-3"<br>  ],<br>  "us-east": [<br>    "us-east-1",<br>    "us-east-2",<br>    "us-east-3"<br>  ],<br>  "us-south": [<br>    "us-south-1",<br>    "us-south-2",<br>    "us-south-3"<br>  ]<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_LOAD_BALANCER"></a> [LOAD\_BALANCER](#output\_LOAD\_BALANCER) | This variable will display the private and public IP addresses and DNS of load balancers |
| <a name="output_VSI"></a> [VSI](#output\_VSI) | This variable will display the private IP address of DB servers and the public IP address of Bastion Server |
