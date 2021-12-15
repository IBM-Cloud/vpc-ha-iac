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
| [ibm_is_ike_policy.ike_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_ike_policy) | resource |
| [ibm_is_ipsec_policy.ipsec_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_ipsec_policy) | resource |
| [ibm_is_vpc_routing_table.vpn_routing_table](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpc_routing_table) | resource |
| [ibm_is_vpc_routing_table_route.routing_table_route](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpc_routing_table_route) | resource |
| [ibm_is_vpn_gateway.vpn_gateway](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpn_gateway) | resource |
| [ibm_is_vpn_gateway_connection.VPNGatewayConnection](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpn_gateway_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Dead peer detection actions, action to take when a peer gateway stops responding. Supported values are restart, clear, hold, or none. Default value is none | `string` | n/a | yes |
| <a name="input_admin_state_up"></a> [admin\_state\_up](#input\_admin\_state\_up) | The VPN gateway connection status. If set to false, the VPN gateway connection is shut down. | `bool` | n/a | yes |
| <a name="input_authentication_algorithm"></a> [authentication\_algorithm](#input\_authentication\_algorithm) | Enter the algorithm that you want to use to authenticate IPSec peers. Available options are md5, sha1, or sha256 | `string` | n/a | yes |
| <a name="input_dh_group"></a> [dh\_group](#input\_dh\_group) | Enter the Diffie-Hellman group that you want to use for the encryption key. Available enumeration type are 2, 5, 14, or 19 | `number` | n/a | yes |
| <a name="input_encryption_algorithm"></a> [encryption\_algorithm](#input\_encryption\_algorithm) | Enter the algorithm that you want to use to encrypt data. Available options are: triple\_des, aes128, or aes256 | `string` | n/a | yes |
| <a name="input_ike_version"></a> [ike\_version](#input\_ike\_version) | Enter the IKE protocol version that you want to use. Available options are 1, or 2 | `number` | n/a | yes |
| <a name="input_interval"></a> [interval](#input\_interval) | Dead peer detection interval in seconds. How often to test that the peer gateway is responsive. | `number` | n/a | yes |
| <a name="input_key_lifetime"></a> [key\_lifetime](#input\_key\_lifetime) | The key lifetime in seconds. Maximum: 86400, Minimum: 1800. Length of time that a secret key is valid for the tunnel in the phase before it must be renegotiated. | `map(number)` | n/a | yes |
| <a name="input_local_cidrs"></a> [local\_cidrs](#input\_local\_cidrs) | List of local CIDRs for the creation of VPN connection. | `list(any)` | n/a | yes |
| <a name="input_peer_cidrs"></a> [peer\_cidrs](#input\_peer\_cidrs) | List of peer CIDRs for the creation of VPN connection. | `list(any)` | n/a | yes |
| <a name="input_peer_gateway_ip"></a> [peer\_gateway\_ip](#input\_peer\_gateway\_ip) | The IP address of the peer VPN gateway. | `string` | n/a | yes |
| <a name="input_perfect_forward_secrecy"></a> [perfect\_forward\_secrecy](#input\_perfect\_forward\_secrecy) | Enter the Perfect Forward Secrecy protocol that you want to use during a session. Available options are disabled, group\_2, group\_5, and group\_14 | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_preshared_key"></a> [preshared\_key](#input\_preshared\_key) | The Key configured on the peer gateway. The key is usually a complex string similar to a password. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | Subnet in which VPN gateway will be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Enter any tags that you want to associate with your VPN. Tags might help you find your VPN more easily after it is created. Separate multiple tags with a comma (,) | `list(any)` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Dead peer detection timeout in seconds. Defines the timeout interval after which all connections to a peer are deleted due to inactivity. This timeout applies only to IKEv1. | `number` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |
| <a name="input_vpn_mode"></a> [vpn\_mode](#input\_vpn\_mode) | Mode in VPN gateway. Supported values are route or policy. | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | List of Availability Zones where VPN will be created | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peer_gateway_ip"></a> [peer\_gateway\_ip](#output\_peer\_gateway\_ip) | This variable will display vpn gateway id |
| <a name="output_routing_table_id"></a> [routing\_table\_id](#output\_routing\_table\_id) | This variable will display routing table id |
