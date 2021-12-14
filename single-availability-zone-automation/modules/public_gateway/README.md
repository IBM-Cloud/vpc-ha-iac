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
| [ibm_is_public_gateway.pg](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_public_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone where the public gateway will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pg_id"></a> [pg\_id](#output\_pg\_id) | n/a |
