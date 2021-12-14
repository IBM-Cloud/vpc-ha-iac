## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.32.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion |  |
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/instance |  |
| <a name="module_instance_group"></a> [instance\_group](#module\_instance\_group) | ./modules/instance_group |  |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancer |  |
| <a name="module_public_gateway"></a> [public\_gateway](#module\_public\_gateway) | ./modules/public_gateway |  |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security_group |  |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnet |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc |  |
| <a name="module_vpn"></a> [vpn](#module\_vpn) | ./modules/vpn |  |

## Resources

| Name | Type |
|------|------|
| [time_sleep.wait_600_seconds_app](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [ibm_is_ssh_key.bastion_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.32.0/docs/data-sources/is_ssh_key) | data source |
| [ibm_is_ssh_key.ssh_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.32.0/docs/data-sources/is_ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none | `string` | `"none"` | no |
| <a name="input_admin_state_up"></a> [admin\_state\_up](#input\_admin\_state\_up) | The VPN gateway connection status. If set to false, the VPN gateway connection is shut down. | `bool` | `"true"` | no |
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | This is the Application load balancer listener port | `number` | `"80"` | no |
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Please enter the IBM Cloud API key. | `string` | n/a | yes |
| <a name="input_app_aggregation_window"></a> [app\_aggregation\_window](#input\_app\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | `90` | no |
| <a name="input_app_config"></a> [app\_config](#input\_app\_config) | Application Configurations to be passed for App Instance Group creation | `map(any)` | <pre>{<br>  "application_port": "80",<br>  "instance_profile": "cx2-2x4",<br>  "memory_percent": "70",<br>  "network_in": "4000",<br>  "network_out": "4000"<br>}</pre> | no |
| <a name="input_app_cooldown_time"></a> [app\_cooldown\_time](#input\_app\_cooldown\_time) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | `120` | no |
| <a name="input_app_cpu_threshold"></a> [app\_cpu\_threshold](#input\_app\_cpu\_threshold) | Average target CPU Percent for CPU policy of App Instance Group | `number` | n/a | yes |
| <a name="input_app_image"></a> [app\_image](#input\_app\_image) | Custom image id for the app VSI | `string` | n/a | yes |
| <a name="input_app_max_servers_count"></a> [app\_max\_servers\_count](#input\_app\_max\_servers\_count) | Maximum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_app_min_servers_count"></a> [app\_min\_servers\_count](#input\_app\_min\_servers\_count) | Minimum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_app_os_type"></a> [app\_os\_type](#input\_app\_os\_type) | OS image to be used linux for App Server | `string` | n/a | yes |
| <a name="input_authentication_algorithm"></a> [authentication\_algorithm](#input\_authentication\_algorithm) | Enter the algorithm that you want to use to authenticate IPSec peers. Available options are md5, sha1, sha256, or sha512 | `string` | `"md5"` | no |
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Bandwidth per second in GB. The possible values are 3, 5 and 10 | `number` | n/a | yes |
| <a name="input_bastion_image"></a> [bastion\_image](#input\_bastion\_image) | Custom image id for the Bastion VSI | `string` | n/a | yes |
| <a name="input_bastion_ip_count"></a> [bastion\_ip\_count](#input\_bastion\_ip\_count) | IP count is the total number of total\_ipv4\_address\_count for Bastion Subnet | `number` | `16` | no |
| <a name="input_bastion_os_type"></a> [bastion\_os\_type](#input\_bastion\_os\_type) | OS image to be used linux for Bastion server | `string` | n/a | yes |
| <a name="input_bastion_profile"></a> [bastion\_profile](#input\_bastion\_profile) | Specify the profile needed for Bastion VSI | `string` | `"cx2-2x4"` | no |
| <a name="input_bastion_ssh_key_var_name"></a> [bastion\_ssh\_key\_var\_name](#input\_bastion\_ssh\_key\_var\_name) | This is the name of the ssh key which will be generated dynamically on the bastion server and further will be attached with all the other Web/App/DB servers. It will be used to login to Web/App/DB servers via Bastion server only. | `string` | `"bastion-ssh-key"` | no |
| <a name="input_data_vol_size"></a> [data\_vol\_size](#input\_data\_vol\_size) | Storage size in GB. The value should be between 10 and 2000 | `number` | `"10"` | no |
| <a name="input_db_image"></a> [db\_image](#input\_db\_image) | Custom image id for the Database VSI | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database will be created with the specified name | `string` | n/a | yes |
| <a name="input_db_os_type"></a> [db\_os\_type](#input\_db\_os\_type) | OS image to be used linux for DB Server | `string` | n/a | yes |
| <a name="input_db_profile"></a> [db\_profile](#input\_db\_profile) | Hardware configuration profile for the Database VSI. | `string` | `"cx2-2x4"` | no |
| <a name="input_db_pwd"></a> [db\_pwd](#input\_db\_pwd) | Database user will be created with the specified password | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Database user will be created with the specified name | `string` | n/a | yes |
| <a name="input_dh_group"></a> [dh\_group](#input\_dh\_group) | Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 2, 5, 14, or 19 | `number` | `2` | no |
| <a name="input_encryption_algorithm"></a> [encryption\_algorithm](#input\_encryption\_algorithm) | Enter the algorithm that you want to use to encrypt data. Available options are: triple\_des, aes128, or aes256 | `string` | `"triple_des"` | no |
| <a name="input_ike_version"></a> [ike\_version](#input\_ike\_version) | Enter the IKE protocol version that you want to use. Available options are 1, or 2 | `number` | `2` | no |
| <a name="input_interval"></a> [interval](#input\_interval) | Dead peer detection interval in seconds. How often to test that the peer gateway is responsive. | `number` | `"30"` | no |
| <a name="input_key_lifetime"></a> [key\_lifetime](#input\_key\_lifetime) | The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated. | `map(number)` | <pre>{<br>  "ike": 28800,<br>  "ipsec": 3600<br>}</pre> | no |
| <a name="input_lb_algo"></a> [lb\_algo](#input\_lb\_algo) | lbaaS backend distribution algorithm | `map(any)` | <pre>{<br>  "least-x": "least_connections",<br>  "rr": "round_robin",<br>  "wrr": "weighted_round_robin"<br>}</pre> | no |
| <a name="input_lb_port_number"></a> [lb\_port\_number](#input\_lb\_port\_number) | declare lbaaS pool member port number | `map(any)` | <pre>{<br>  "custom": "xxx",<br>  "http": "80",<br>  "https": "443"<br>}</pre> | no |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | lbaaS protocols | `map(any)` | <pre>{<br>  "443": "https",<br>  "80": "http",<br>  "l4-tcp": "tcp"<br>}</pre> | no |
| <a name="input_lb_type_private"></a> [lb\_type\_private](#input\_lb\_type\_private) | This variable will hold the Load Balancer type as private | `string` | `"private"` | no |
| <a name="input_lb_type_public"></a> [lb\_type\_public](#input\_lb\_type\_public) | This variable will hold the Load Balancer type as public | `string` | `"public"` | no |
| <a name="input_local_machine_os_type"></a> [local\_machine\_os\_type](#input\_local\_machine\_os\_type) | Operating System to be used [windows \| mac \| linux] for your local machine which is running terraform apply | `string` | n/a | yes |
| <a name="input_my_public_ip"></a> [my\_public\_ip](#input\_my\_public\_ip) | Provide the User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply | `string` | n/a | yes |
| <a name="input_peer_cidrs"></a> [peer\_cidrs](#input\_peer\_cidrs) | List of peer CIDRs for the creation of VPN connection. | `list(string)` | n/a | yes |
| <a name="input_peer_gateway_ip"></a> [peer\_gateway\_ip](#input\_peer\_gateway\_ip) | The IP address of the peer VPN gateway. | `string` | n/a | yes |
| <a name="input_perfect_forward_secrecy"></a> [perfect\_forward\_secrecy](#input\_perfect\_forward\_secrecy) | Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group\_2, group\_5, and group\_14 | `string` | `"disabled"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this script. | `string` | n/a | yes |
| <a name="input_preshared_key"></a> [preshared\_key](#input\_preshared\_key) | The Key configured on the peer gateway. The key is usually a complex string similar to a password. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Please enter a region from the following available region and zones mapping: <br>us-south<br>us-east<br>eu-gb<br>eu-de<br>jp-tok<br>au-syd | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID | `string` | n/a | yes |
| <a name="input_tiered_profiles"></a> [tiered\_profiles](#input\_tiered\_profiles) | Tiered profiles for Input/Output per seconds in GBs | `map(any)` | <pre>{<br>  "10": "10iops-tier",<br>  "3": "general-purpose",<br>  "5": "5iops-tier"<br>}</pre> | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1. | `number` | `"120"` | no |
| <a name="input_user_ssh_key"></a> [user\_ssh\_key](#input\_user\_ssh\_key) | This is the existing ssh key on the User's machine and will be attached with the bastion server only. This will ensure the incoming connection on Bastion Server only from the users provided ssh\_keys. You can check your key name in IBM cloud. Whose private key content should be there in path ~/.ssh/id\_rsa | `string` | n/a | yes |
| <a name="input_vpn_mode"></a> [vpn\_mode](#input\_vpn\_mode) | Mode in VPN gateway. Supported values are route or policy. | `string` | n/a | yes |
| <a name="input_web_aggregation_window"></a> [web\_aggregation\_window](#input\_web\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | `90` | no |
| <a name="input_web_config"></a> [web\_config](#input\_web\_config) | Web Configurations to be passed for Web Instance Group creation | `map(any)` | <pre>{<br>  "application_port": "80",<br>  "instance_profile": "cx2-2x4",<br>  "memory_percent": "70",<br>  "network_in": "4000",<br>  "network_out": "4000"<br>}</pre> | no |
| <a name="input_web_cooldown_time"></a> [web\_cooldown\_time](#input\_web\_cooldown\_time) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | `120` | no |
| <a name="input_web_cpu_threshold"></a> [web\_cpu\_threshold](#input\_web\_cpu\_threshold) | Average target CPU Percent for CPU policy of Web Instance Group | `number` | n/a | yes |
| <a name="input_web_image"></a> [web\_image](#input\_web\_image) | Custom image id for the web VSI | `string` | n/a | yes |
| <a name="input_web_max_servers_count"></a> [web\_max\_servers\_count](#input\_web\_max\_servers\_count) | Maximum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_web_min_servers_count"></a> [web\_min\_servers\_count](#input\_web\_min\_servers\_count) | Minimum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_web_os_type"></a> [web\_os\_type](#input\_web\_os\_type) | OS image to be used linux for Web Server | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | Region and zones mapping | `map(any)` | <pre>{<br>  "au-syd": [<br>    "au-syd-1",<br>    "au-syd-2",<br>    "au-syd-3"<br>  ],<br>  "br-sao": [<br>    "br-sao-1",<br>    "br-sao-2",<br>    "br-sao-3"<br>  ],<br>  "ca-tor": [<br>    "ca-tor-1",<br>    "ca-tor-2",<br>    "ca-tor-3"<br>  ],<br>  "eu-de": [<br>    "eu-de-1",<br>    "eu-de-2",<br>    "eu-de-3"<br>  ],<br>  "eu-gb": [<br>    "eu-gb-1",<br>    "eu-gb-2",<br>    "eu-gb-3"<br>  ],<br>  "jp-osa": [<br>    "jp-osa-1",<br>    "jp-osa-2",<br>    "jp-osa-3"<br>  ],<br>  "jp-tok": [<br>    "jp-tok-1",<br>    "jp-tok-2",<br>    "jp-tok-3"<br>  ],<br>  "us-east": [<br>    "us-east-1",<br>    "us-east-2",<br>    "us-east-3"<br>  ],<br>  "us-south": [<br>    "us-south-1",<br>    "us-south-2",<br>    "us-south-3"<br>  ]<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_LOAD_BALANCER"></a> [LOAD\_BALANCER](#output\_LOAD\_BALANCER) | This variable will display the private and public IP addresses and DNS of load balancers |
| <a name="output_VSI"></a> [VSI](#output\_VSI) | This variable will display the private IP address of DB servers and the public IP address of Bastion Server |
