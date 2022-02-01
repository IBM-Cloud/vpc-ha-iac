## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.37.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_instance_group.app_instance_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group) | resource |
| [ibm_is_instance_group.web_instance_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group) | resource |
| [ibm_is_instance_group_manager.app_instance_group_manager](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager) | resource |
| [ibm_is_instance_group_manager.web_instance_group_manager](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager) | resource |
| [ibm_is_instance_group_manager_policy.app_cpu_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.app_memory_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.app_network_in_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.app_network_out_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_cpu_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_memory_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_network_in_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_network_out_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_template.app_template](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_template) | resource |
| [ibm_is_instance_template.web_template](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance_template) | resource |
| [ibm_is_image.app_os](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_image) | data source |
| [ibm_is_image.web_os](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_image) | data source |
| [ibm_is_instances.app_ig_members](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_instances) | data source |
| [ibm_is_instances.web_ig_members](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_instances) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_aggregation_window"></a> [app\_aggregation\_window](#input\_app\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | n/a | yes |
| <a name="input_app_config"></a> [app\_config](#input\_app\_config) | Application Configurations to be passed for App Instance Group creation | `map(any)` | n/a | yes |
| <a name="input_app_cooldown_time"></a> [app\_cooldown\_time](#input\_app\_cooldown\_time) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | n/a | yes |
| <a name="input_app_cpu_threshold"></a> [app\_cpu\_threshold](#input\_app\_cpu\_threshold) | Average target CPU Percent for CPU policy of App Instance Group | `number` | n/a | yes |
| <a name="input_app_image"></a> [app\_image](#input\_app\_image) | Image id for the App VSI for App Instance group template | `string` | n/a | yes |
| <a name="input_app_max_servers_count"></a> [app\_max\_servers\_count](#input\_app\_max\_servers\_count) | Maximum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_app_min_servers_count"></a> [app\_min\_servers\_count](#input\_app\_min\_servers\_count) | Minimum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_app_placement_group_id"></a> [app\_placement\_group\_id](#input\_app\_placement\_group\_id) | Placement group ID to be used for App servers. | `string` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database will be created with the specified name | `string` | n/a | yes |
| <a name="input_db_private_ip"></a> [db\_private\_ip](#input\_db\_private\_ip) | This variable contains the value of DB private IP which is used for connection. | `string` | n/a | yes |
| <a name="input_db_pwd"></a> [db\_pwd](#input\_db\_pwd) | Database user will be created with the specified password | `string` | n/a | yes |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | Database user will be created with the specified name | `string` | n/a | yes |
| <a name="input_objects"></a> [objects](#input\_objects) | This variable will contains the objects of LB, LB Pool and LB Listeners. | <pre>object({<br>    lb       = map(any)<br>    pool     = map(any)<br>    listener = map(any)<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this Module | `string` | n/a | yes |
| <a name="input_reregister_rhel"></a> [reregister\_rhel](#input\_reregister\_rhel) | Reregister script for rhel 7.9 for mirror yum repos | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_sg_objects"></a> [sg\_objects](#input\_sg\_objects) | All Security Group objects. This is required parameter | `map(any)` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | This is the ssh-key used to connect to the app/web/db VSI from Bastion VSI | `list(any)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | All subnet objects. This is required parameter | <pre>object({<br>    app = any<br>    web = any<br>  })</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_web_aggregation_window"></a> [web\_aggregation\_window](#input\_web\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | n/a | yes |
| <a name="input_web_config"></a> [web\_config](#input\_web\_config) | Web Configurations to be passed for Web Instance Group creation | `map(any)` | n/a | yes |
| <a name="input_web_cooldown_time"></a> [web\_cooldown\_time](#input\_web\_cooldown\_time) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | n/a | yes |
| <a name="input_web_cpu_threshold"></a> [web\_cpu\_threshold](#input\_web\_cpu\_threshold) | Average target CPU Percent for CPU policy of Web Instance Group | `number` | n/a | yes |
| <a name="input_web_image"></a> [web\_image](#input\_web\_image) | Image id for the Web VSI for Web Instance group template | `string` | n/a | yes |
| <a name="input_web_lb_hostname"></a> [web\_lb\_hostname](#input\_web\_lb\_hostname) | Web Load balancer hostname | `string` | n/a | yes |
| <a name="input_web_max_servers_count"></a> [web\_max\_servers\_count](#input\_web\_max\_servers\_count) | Maximum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_web_min_servers_count"></a> [web\_min\_servers\_count](#input\_web\_min\_servers\_count) | Minimum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_web_placement_group_id"></a> [web\_placement\_group\_id](#input\_web\_placement\_group\_id) | Placement group ID to be used for Web servers. | `string` | n/a | yes |
| <a name="input_wp_admin_email"></a> [wp\_admin\_email](#input\_wp\_admin\_email) | Email of the Admin User for the wordpress website | `string` | n/a | yes |
| <a name="input_wp_admin_password"></a> [wp\_admin\_password](#input\_wp\_admin\_password) | Password of the Admin User for the wordpress website | `string` | n/a | yes |
| <a name="input_wp_admin_user"></a> [wp\_admin\_user](#input\_wp\_admin\_user) | Name of the Admin User of the wordpress website | `string` | n/a | yes |
| <a name="input_wp_blog_title"></a> [wp\_blog\_title](#input\_wp\_blog\_title) | Title of the website or blog | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Resources will be created in the user specified zone | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_instances_ip"></a> [app\_instances\_ip](#output\_app\_instances\_ip) | n/a |
| <a name="output_web_instances_ip"></a> [web\_instances\_ip](#output\_web\_instances\_ip) | n/a |
