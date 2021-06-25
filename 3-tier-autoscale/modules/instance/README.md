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
| [ibm_is_instance.db](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance) | resource |
| [ibm_is_volume.data_volume](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | Bandwidth per second in GB. The possible values are 3, 5 and 10 | `number` | n/a | yes |
| <a name="input_db_image"></a> [db\_image](#input\_db\_image) | Image for DB VSI | `string` | n/a | yes |
| <a name="input_db_profile"></a> [db\_profile](#input\_db\_profile) | DB Profile | `string` | n/a | yes |
| <a name="input_db_sg"></a> [db\_sg](#input\_db\_sg) | DB Security Group | `string` | n/a | yes |
| <a name="input_dlb_id"></a> [dlb\_id](#input\_dlb\_id) | DB Load Balancer ID | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | Storage size in GB. The value should be between 10 and 2000 | `number` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | ssh keys for the vsi | `list(any)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | DB subnets Ids. This is required parameter | `list(any)` | n/a | yes |
| <a name="input_tiered_profiles"></a> [tiered\_profiles](#input\_tiered\_profiles) | Tiered profiles for Input/Output per seconds in GBs | `map(any)` | <pre>{<br>  "10": "10iops-tier",<br>  "3": "general-purpose",<br>  "5": "5iops-tier"<br>}</pre> | no |
| <a name="input_total_instance"></a> [total\_instance](#input\_total\_instance) | Please enter the total number of instances you want to create in each zones. | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | List of Availability Zones where compute resource will be created | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_target"></a> [db\_target](#output\_db\_target) | Target primary network interface address |
| <a name="output_db_vsi"></a> [db\_vsi](#output\_db\_vsi) | Target primary network interface address |
