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
| [ibm_is_instance.app](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance) | resource |
| [ibm_is_instance.db](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance) | resource |
| [ibm_is_instance.web](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_id"></a> [alb\_id](#input\_alb\_id) | App Load Balancer ID | `any` | n/a | yes |
| <a name="input_app_image"></a> [app\_image](#input\_app\_image) | This variable will hold the image name for app instance | `string` | n/a | yes |
| <a name="input_app_profile"></a> [app\_profile](#input\_app\_profile) | This variable will hold the image profile name for app instance | `string` | n/a | yes |
| <a name="input_app_sg"></a> [app\_sg](#input\_app\_sg) | App Security Group | `any` | n/a | yes |
| <a name="input_app_subnet"></a> [app\_subnet](#input\_app\_subnet) | App subnets Ids. This is required parameter | `any` | n/a | yes |
| <a name="input_bastion_sg"></a> [bastion\_sg](#input\_bastion\_sg) | Bastion Security Group | `any` | n/a | yes |
| <a name="input_db_image"></a> [db\_image](#input\_db\_image) | This variable will hold the image name for db instance | `string` | n/a | yes |
| <a name="input_db_profile"></a> [db\_profile](#input\_db\_profile) | This variable will hold the image profile name for db instance | `string` | n/a | yes |
| <a name="input_db_sg"></a> [db\_sg](#input\_db\_sg) | DB Security Group | `any` | n/a | yes |
| <a name="input_db_subnet"></a> [db\_subnet](#input\_db\_subnet) | DB subnets Ids. This is required parameter | `any` | n/a | yes |
| <a name="input_db_vsi_count"></a> [db\_vsi\_count](#input\_db\_vsi\_count) | Total Database instances that will be created in the user specified region. | `number` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group Id is used to seperated the resources in a group. | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | ssh keys for the vsi | `any` | n/a | yes |
| <a name="input_total_instance"></a> [total\_instance](#input\_total\_instance) | Please enter the total number of instances you want to create in each zones. | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `any` | n/a | yes |
| <a name="input_web_image"></a> [web\_image](#input\_web\_image) | This variable will hold the image name for web instance | `string` | n/a | yes |
| <a name="input_web_profile"></a> [web\_profile](#input\_web\_profile) | This variable will hold the image profile name for web instance | `string` | n/a | yes |
| <a name="input_web_sg"></a> [web\_sg](#input\_web\_sg) | Web Security Group | `any` | n/a | yes |
| <a name="input_web_subnet"></a> [web\_subnet](#input\_web\_subnet) | Web subnets Ids. This is required parameter | `any` | n/a | yes |
| <a name="input_wlb_id"></a> [wlb\_id](#input\_wlb\_id) | Web Load Balancer ID | `any` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | List of Availability Zones where compute resource will be created | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_target"></a> [app\_target](#output\_app\_target) | Target primary network interface address |
| <a name="output_app_vsi"></a> [app\_vsi](#output\_app\_vsi) | Target primary network interface address |
| <a name="output_db_target"></a> [db\_target](#output\_db\_target) | Target primary network interface address |
| <a name="output_db_vsi"></a> [db\_vsi](#output\_db\_vsi) | Target primary network interface address |
| <a name="output_web_target"></a> [web\_target](#output\_web\_target) | Target primary network interface address |
| <a name="output_web_vsi"></a> [web\_vsi](#output\_web\_vsi) | Target primary network interface address |
