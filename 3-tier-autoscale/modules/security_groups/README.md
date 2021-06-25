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
| [ibm_is_security_group.app](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group) | resource |
| [ibm_is_security_group.bastion](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group) | resource |
| [ibm_is_security_group.db](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group) | resource |
| [ibm_is_security_group.lb_sg](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group) | resource |
| [ibm_is_security_group.web](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group) | resource |
| [ibm_is_security_group_rule.app_outbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.app_rule_22](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.app_rule_80](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.app_rule_lb_listener](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.bastion_outbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.bastion_rule_22](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.db_outbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.db_rule_22](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.db_rule_80](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.db_rule_lb_listener](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.lb_inbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.lb_outbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.web_outbound](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.web_rule_22](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.web_rule_443](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |
| [ibm_is_security_group_rule.web_rule_80](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.26.0/docs/resources/is_security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | This is the Application load balancer listener port | `number` | n/a | yes |
| <a name="input_dlb_port"></a> [dlb\_port](#input\_dlb\_port) | This is the DB load balancer listener port | `number` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group Name is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_user_ip_address"></a> [user\_ip\_address](#input\_user\_ip\_address) | Provide the User's Public IP address in the format X.X.X.X which will be used to login to Bastion VSI. Also Please update your changed public IP address everytime before executing terraform apply | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_sg"></a> [app\_sg](#output\_app\_sg) | Security Group id for the app |
| <a name="output_bastion_sg"></a> [bastion\_sg](#output\_bastion\_sg) | Security Group id for the bastion |
| <a name="output_db_sg"></a> [db\_sg](#output\_db\_sg) | Security Group id for the db |
| <a name="output_lb_sg"></a> [lb\_sg](#output\_lb\_sg) | Security Group ID for Load Balancer |
| <a name="output_sg_objects"></a> [sg\_objects](#output\_sg\_objects) | This output variable will expose the objects of all security groups |
| <a name="output_web_sg"></a> [web\_sg](#output\_web\_sg) | Security Group id for the web |
