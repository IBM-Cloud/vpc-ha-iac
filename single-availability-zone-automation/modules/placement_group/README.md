## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_placement_group.app_placement_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_placement_group) | resource |
| [ibm_is_placement_group.db_placement_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_placement_group) | resource |
| [ibm_is_placement_group.web_placement_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_placement_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_pg_strategy"></a> [app\_pg\_strategy](#input\_app\_pg\_strategy) | The strategy for App servers placement group - host\_spread: place on different compute hosts - power\_spread: place on compute hosts that use different power sources. | `string` | n/a | yes |
| <a name="input_db_pg_strategy"></a> [db\_pg\_strategy](#input\_db\_pg\_strategy) | The strategy for Database servers placement group - host\_spread: place on different compute hosts - power\_spread: place on compute hosts that use different power sources. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group Name is used to separate the resources in a group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The user tags to attach to the placement group. | `list(any)` | `null` | no |
| <a name="input_web_pg_strategy"></a> [web\_pg\_strategy](#input\_web\_pg\_strategy) | The strategy for Web servers placement group - host\_spread: place on different compute hosts - power\_spread: place on compute hosts that use different power sources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_pg_id"></a> [app\_pg\_id](#output\_app\_pg\_id) | Placement group ID for App servers |
| <a name="output_db_pg_id"></a> [db\_pg\_id](#output\_db\_pg\_id) | Placement group ID for Database servers |
| <a name="output_web_pg_id"></a> [web\_pg\_id](#output\_web\_pg\_id) | Placement group ID for Web servers |
