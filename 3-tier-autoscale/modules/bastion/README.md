## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.26.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.0.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.26.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | 3.0.0 |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_floating_ip.bastion_floating_ip](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_floating_ip) | resource |
| [ibm_is_instance.bastion](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_instance) | resource |
| [ibm_is_ssh_key.iac_shared_ssh_key](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_ssh_key) | resource |
| [null_resource.copy_ssh_key](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [time_sleep.wait_60_seconds](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [local_file.input](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion_image"></a> [bastion\_image](#input\_bastion\_image) | Specify Image to be used with Bastion VSI | `string` | `"r006-78fafd7c-4fc6-4373-a58a-637ba6dc3ee8"` | no |
| <a name="input_bastion_profile"></a> [bastion\_profile](#input\_bastion\_profile) | Specify the profile needed for Bastion VSI | `string` | n/a | yes |
| <a name="input_bastion_ssh_key"></a> [bastion\_ssh\_key](#input\_bastion\_ssh\_key) | This is the name of the ssh key which will be generated dynamically on the bastion server and further will be attached with all the other Web/App/DB servers. It will be used to login to Web/App/DB servers via Bastion server only. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group Name is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | Bastion Security Group ID | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Bastion Subnet ID | `string` | n/a | yes |
| <a name="input_user_ssh_key"></a> [user\_ssh\_key](#input\_user\_ssh\_key) | This is the existing ssh key on the User's machine and will be attached with the bastion server only. This will ensure the incoming connection on Bastion Server only from the users provided ssh\_keys | `list(any)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | List of Availability Zones where bastion resource will be created | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_ip"></a> [bastion\_ip](#output\_bastion\_ip) | Bastion Server Floating IP Address |
| <a name="output_bastion_ssh_key"></a> [bastion\_ssh\_key](#output\_bastion\_ssh\_key) | SSH Key created dynamically from Bastion vsi for app/web/db servers |
