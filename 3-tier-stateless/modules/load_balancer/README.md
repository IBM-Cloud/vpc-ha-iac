## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.39.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_lb.app_lb](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb) | resource |
| [ibm_is_lb.web_lb](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb) | resource |
| [ibm_is_lb_listener.app_listener](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_listener) | resource |
| [ibm_is_lb_listener.web_listener](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_listener) | resource |
| [ibm_is_lb_pool.app_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool) | resource |
| [ibm_is_lb_pool.web_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool) | resource |
| [ibm_is_lb_pool_member.app_lb_member](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool_member) | resource |
| [ibm_is_lb_pool_member.web_lb_member](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | This is the Application load balancer listener port | `number` | n/a | yes |
| <a name="input_app_subnet"></a> [app\_subnet](#input\_app\_subnet) | App subnets Ids. This is required parameter | `any` | n/a | yes |
| <a name="input_app_target"></a> [app\_target](#input\_app\_target) | Target interface address of the app server | `any` | n/a | yes |
| <a name="input_app_vsi"></a> [app\_vsi](#input\_app\_vsi) | VSI reference for app from the instance module | `any` | n/a | yes |
| <a name="input_lb_algo"></a> [lb\_algo](#input\_lb\_algo) | lbaaS backend distribution algorithm | `map(any)` | n/a | yes |
| <a name="input_lb_port_number"></a> [lb\_port\_number](#input\_lb\_port\_number) | declare lbaaS pool member port numbert | `map(any)` | n/a | yes |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | lbaaS protocols | `map(any)` | n/a | yes |
| <a name="input_lb_sg"></a> [lb\_sg](#input\_lb\_sg) | Load Balancer Security Group | `any` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group Id is used to seperated the resources in a group. | `string` | n/a | yes |
| <a name="input_total_instance"></a> [total\_instance](#input\_total\_instance) | Total number of instances that will be created. | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `any` | n/a | yes |
| <a name="input_web_subnet"></a> [web\_subnet](#input\_web\_subnet) | Web subnets Ids. This is required parameter | `any` | n/a | yes |
| <a name="input_web_target"></a> [web\_target](#input\_web\_target) | Target interface address of the web server | `any` | n/a | yes |
| <a name="input_web_vsi"></a> [web\_vsi](#input\_web\_vsi) | VSI reference for web from the instance module | `any` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | List of Availability Zones where compute resource will be created | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_lb_id"></a> [app\_lb\_id](#output\_app\_lb\_id) | App load balancer ID |
| <a name="output_lb_dns"></a> [lb\_dns](#output\_lb\_dns) | Private IP for App, DB and Web Server |
| <a name="output_lb_private_ip"></a> [lb\_private\_ip](#output\_lb\_private\_ip) | Private IP for App and DB Server |
| <a name="output_lb_public_ip"></a> [lb\_public\_ip](#output\_lb\_public\_ip) | Public IP for Web Server |
| <a name="output_objects"></a> [objects](#output\_objects) | This variable will contains the objects of LB, LB Pool and LB Listeners. |
| <a name="output_web_lb_id"></a> [web\_lb\_id](#output\_web\_lb\_id) | Web load balancer ID |
