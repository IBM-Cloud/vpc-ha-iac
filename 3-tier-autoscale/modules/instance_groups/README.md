## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_instance_group.app_instance_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group) | resource |
| [ibm_is_instance_group.web_instance_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group) | resource |
| [ibm_is_instance_group_manager.app_instance_group_manager](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager) | resource |
| [ibm_is_instance_group_manager.web_instance_group_manager](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager) | resource |
| [ibm_is_instance_group_manager_policy.app_cpu_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.app_memory_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.app_network_in_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.app_network_out_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_cpu_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_memory_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_network_in_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_group_manager_policy.web_network_out_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_group_manager_policy) | resource |
| [ibm_is_instance_template.app_template](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_template) | resource |
| [ibm_is_instance_template.web_template](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_aggregation_window"></a> [app\_aggregation\_window](#input\_app\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | `90` | no |
| <a name="input_app_config"></a> [app\_config](#input\_app\_config) | Application Configurations to be passed for App Instance Group creation | `map(any)` | n/a | yes |
| <a name="input_app_cool_down"></a> [app\_cool\_down](#input\_app\_cool\_down) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | `120` | no |
| <a name="input_app_cpu_percent"></a> [app\_cpu\_percent](#input\_app\_cpu\_percent) | Average target CPU Percent for CPU policy of App Instance Group | `number` | n/a | yes |
| <a name="input_app_max_servers_count"></a> [app\_max\_servers\_count](#input\_app\_max\_servers\_count) | Maximum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_app_min_servers_count"></a> [app\_min\_servers\_count](#input\_app\_min\_servers\_count) | Minimum App servers count for the App Instance group | `number` | n/a | yes |
| <a name="input_objects"></a> [objects](#input\_objects) | This variable will contains the objects of LB, LB Pool and LB Listeners. | <pre>object({<br>    lb       = map(any)<br>    pool     = map(any)<br>    listener = map(any)<br>  })</pre> | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this Module | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_sg_objects"></a> [sg\_objects](#input\_sg\_objects) | All Security Group objects. This is required parameter | `map(any)` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | This is the ssh-key used to connect to the app/web/db VSI from Bastion VSI | `list(any)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | All subnet objects. This is required parameter | <pre>object({<br>    app = list(any)<br>    web = list(any)<br>  })</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_web_aggregation_window"></a> [web\_aggregation\_window](#input\_web\_aggregation\_window) | The aggregation window is the time period in seconds that the instance group manager monitors each instance and determines the average utilization. | `number` | `90` | no |
| <a name="input_web_config"></a> [web\_config](#input\_web\_config) | Web Configurations to be passed for Web Instance Group creation | `map(any)` | n/a | yes |
| <a name="input_web_cool_down"></a> [web\_cool\_down](#input\_web\_cool\_down) | Specify the cool down period, the number of seconds to pause further scaling actions after scaling has taken place. | `number` | `120` | no |
| <a name="input_web_cpu_percent"></a> [web\_cpu\_percent](#input\_web\_cpu\_percent) | Average target CPU Percent for CPU policy of Web Instance Group | `number` | n/a | yes |
| <a name="input_web_max_servers_count"></a> [web\_max\_servers\_count](#input\_web\_max\_servers\_count) | Maximum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_web_min_servers_count"></a> [web\_min\_servers\_count](#input\_web\_min\_servers\_count) | Minimum Web servers count for the Web Instance group | `number` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | List of Availability Zones where compute resource will be created | `list(any)` | n/a | yes |

## Outputs

No outputs.
