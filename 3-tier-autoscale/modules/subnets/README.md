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
| [ibm_is_subnet.app_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_subnet) | resource |
| [ibm_is_subnet.bastion_sub](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_subnet) | resource |
| [ibm_is_subnet.db_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_subnet) | resource |
| [ibm_is_subnet.web_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_ip_count"></a> [bastion\_ip\_count](#input\_bastion\_ip\_count) | IP count is the total number of total\_ipv4\_address\_count for Bastion Subnet | `number` | `8` | no |
| <a name="input_ip_count"></a> [ip\_count](#input\_ip\_count) | Enter total number of IP Address for each subnet | `number` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | List of Availability Zones where compute resource will be created | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sub_objects"></a> [sub\_objects](#output\_sub\_objects) | This output variable will expose the objects of all subnets |
