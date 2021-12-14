## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.33.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_lb.app_lb](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb) | resource |
| [ibm_is_lb.db_lb](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb) | resource |
| [ibm_is_lb.web_lb](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb) | resource |
| [ibm_is_lb_listener.app_listener](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_listener) | resource |
| [ibm_is_lb_listener.db_listener](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_listener) | resource |
| [ibm_is_lb_listener.web_listener](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_listener) | resource |
| [ibm_is_lb_pool.app_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool) | resource |
| [ibm_is_lb_pool.db_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool) | resource |
| [ibm_is_lb_pool.web_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool) | resource |
| [ibm_is_lb_pool_member.db_lb_member](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_lb_pool_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | This is the Application load balancer listener port | `number` | n/a | yes |
| <a name="input_db_target"></a> [db\_target](#input\_db\_target) | Target interface address of the DB server | `any` | n/a | yes |
| <a name="input_db_vsi"></a> [db\_vsi](#input\_db\_vsi) | VSI reference for db from the instance module | `any` | n/a | yes |
| <a name="input_dlb_port"></a> [dlb\_port](#input\_dlb\_port) | This is the DB load balancer listener port | `number` | n/a | yes |
| <a name="input_lb_algo"></a> [lb\_algo](#input\_lb\_algo) | lbaaS backend distribution algorithm | `map(any)` | n/a | yes |
| <a name="input_lb_port_number"></a> [lb\_port\_number](#input\_lb\_port\_number) | declare lbaaS pool member port number | `map(any)` | n/a | yes |
| <a name="input_lb_protocol"></a> [lb\_protocol](#input\_lb\_protocol) | lbaaS protocols | `map(any)` | n/a | yes |
| <a name="input_lb_sg"></a> [lb\_sg](#input\_lb\_sg) | Load Balancer Security Group | `string` | n/a | yes |
| <a name="input_lb_type_private"></a> [lb\_type\_private](#input\_lb\_type\_private) | This variable will hold the Load Balancer type as private | `string` | n/a | yes |
| <a name="input_lb_type_public"></a> [lb\_type\_public](#input\_lb\_type\_public) | This variable will hold the Load Balancer type as public | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created for this module. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | All subnet objects. This is required parameter | <pre>object({<br>    app = any<br>    db  = any<br>    web = any<br>  })</pre> | n/a | yes |
| <a name="input_total_instance"></a> [total\_instance](#input\_total\_instance) | Total instances that will be created in the user specified zone. | `number` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Required parameter vpc\_id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_dns"></a> [lb\_dns](#output\_lb\_dns) | Private IP for App, DB and Web Server |
| <a name="output_lb_private_ip"></a> [lb\_private\_ip](#output\_lb\_private\_ip) | Private IP for App and DB Server |
| <a name="output_lb_public_ip"></a> [lb\_public\_ip](#output\_lb\_public\_ip) | Public IP for Web Server |
| <a name="output_objects"></a> [objects](#output\_objects) | This variable will contains the objects of LB, LB Pool and LB Listeners. |
