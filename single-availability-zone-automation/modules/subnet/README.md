## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_subnet.app_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_subnet) | resource |
| [ibm_is_subnet.db_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_subnet) | resource |
| [ibm_is_subnet.web_subnet](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_count"></a> [ip\_count](#input\_ip\_count) | This map contains total number of IP Address for each subnet present in each tier web, app and db | `map(any)` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_public_gateway_id"></a> [public\_gateway\_id](#input\_public\_gateway\_id) | Id of the public gateway where subnets will get attached | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone where the subnet will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sub_objects"></a> [sub\_objects](#output\_sub\_objects) | This output variable will expose the objects of all subnets |
