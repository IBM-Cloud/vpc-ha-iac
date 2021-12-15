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
| [ibm_is_ssh_key.bastion1_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_ssh_key) | data source |
| [ibm_is_ssh_key.bastion2_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion1_key"></a> [bastion1\_key](#input\_bastion1\_key) | SSH key name created by the Bastion-1 server | `string` | n/a | yes |
| <a name="input_bastion2_key"></a> [bastion2\_key](#input\_bastion2\_key) | SSH key name created by the Bastion-2 server | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion1_key_id_op"></a> [bastion1\_key\_id\_op](#output\_bastion1\_key\_id\_op) | This variable will return the SSH key id created by Bastion-1 server |
| <a name="output_bastion2_key_id_op"></a> [bastion2\_key\_id\_op](#output\_bastion2\_key\_id\_op) | This variable will return the SSH key id created by Bastion-2 server |
