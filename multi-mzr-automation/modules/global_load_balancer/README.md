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
| [ibm_cis.cis_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis) | resource |
| [ibm_cis_domain.glb_domain](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_domain) | resource |
| [ibm_cis_global_load_balancer.glb](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_global_load_balancer) | resource |
| [ibm_cis_healthcheck.region1_healthcheck](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_healthcheck) | resource |
| [ibm_cis_healthcheck.region2_healthcheck](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_healthcheck) | resource |
| [ibm_cis_origin_pool.region1_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_origin_pool) | resource |
| [ibm_cis_origin_pool.region2_pool](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cis_origin_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_insecure"></a> [allow\_insecure](#input\_allow\_insecure) | If set to true, the certificate is not validated when the health check uses HTTPS. If set to false, the certificate is validated, even if the health check uses HTTPS. The default value is false. | `bool` | n/a | yes |
| <a name="input_cis_glb_location"></a> [cis\_glb\_location](#input\_cis\_glb\_location) | Location to be used for CIS instance for GLB | `string` | n/a | yes |
| <a name="input_cis_glb_plan"></a> [cis\_glb\_plan](#input\_cis\_glb\_plan) | Plan to be used for CIS instance for GLB | `string` | n/a | yes |
| <a name="input_expected_body"></a> [expected\_body](#input\_expected\_body) | A case-insensitive sub-string to look for in the response body. If this string is not found, the origin will be marked as unhealthy. A null value of “” is allowed to match on any content | `string` | n/a | yes |
| <a name="input_expected_codes"></a> [expected\_codes](#input\_expected\_codes) | The expected HTTP response code or code range of the health check | `string` | n/a | yes |
| <a name="input_follow_redirects"></a> [follow\_redirects](#input\_follow\_redirects) | If set to true, a redirect is followed when a redirect is returned by the origin pool. Is set to false, redirects from the origin pool are not followed | `bool` | n/a | yes |
| <a name="input_glb_domain_name"></a> [glb\_domain\_name](#input\_glb\_domain\_name) | Domain name to be used with global load balancer | `string` | n/a | yes |
| <a name="input_glb_healthcheck_method"></a> [glb\_healthcheck\_method](#input\_glb\_healthcheck\_method) | Method to be used for GLB health check | `string` | n/a | yes |
| <a name="input_glb_healthcheck_path"></a> [glb\_healthcheck\_path](#input\_glb\_healthcheck\_path) | The endpoint path to health check against | `string` | n/a | yes |
| <a name="input_glb_healthcheck_port"></a> [glb\_healthcheck\_port](#input\_glb\_healthcheck\_port) | The TCP port number that you want to use for the health check. | `number` | n/a | yes |
| <a name="input_glb_healthcheck_timeout"></a> [glb\_healthcheck\_timeout](#input\_glb\_healthcheck\_timeout) | The timeout in seconds before marking the health check as failed | `number` | n/a | yes |
| <a name="input_glb_protocol_type"></a> [glb\_protocol\_type](#input\_glb\_protocol\_type) | The protocol to use for the health check | `string` | n/a | yes |
| <a name="input_glb_proxy_enabled"></a> [glb\_proxy\_enabled](#input\_glb\_proxy\_enabled) | Global loadbalancer proxy state | `string` | n/a | yes |
| <a name="input_glb_region1_code"></a> [glb\_region1\_code](#input\_glb\_region1\_code) | Enter the Region code for GLB Geo Routing for Region 1 Pool: <br>Region Code -> Region Name <br>EEU -> Eastern Europe <br>ENAM -> Eastern North America <br>ME -> Middle East <br>NAF -> Northern Africa <br>NEAS -> Northeast Asia <br>NSAM -> Northern South America <br>OC -> Oceania <br>SAF -> Southern Africa <br>SAS -> Southern Asia <br>SEAS -> Southeast Asia <br>SSAM -> Southern South America <br>WEU -> Western Europe <br>WNAM -> Western North America | `string` | n/a | yes |
| <a name="input_glb_region2_code"></a> [glb\_region2\_code](#input\_glb\_region2\_code) | Enter the Region code for GLB Geo Routing for Region 2 Pool: <br>Region Code -> Region Name <br>EEU -> Eastern Europe <br>ENAM -> Eastern North America <br>ME -> Middle East <br>NAF -> Northern Africa <br>NEAS -> Northeast Asia <br>NSAM -> Northern South America <br>OC -> Oceania <br>SAF -> Southern Africa <br>SAS -> Southern Asia <br>SEAS -> Southeast Asia <br>SSAM -> Southern South America <br>WEU -> Western Europe <br>WNAM -> Western North America | `string` | n/a | yes |
| <a name="input_glb_traffic_steering"></a> [glb\_traffic\_steering](#input\_glb\_traffic\_steering) | GLB traffic Steering Policy which allows off,geo,random,dynamic\_latency | `string` | n/a | yes |
| <a name="input_interval"></a> [interval](#input\_interval) | The interval between each health check. Shorter intervals may improve failover time, but will increase load on the origins as we check from multiple locations | `number` | n/a | yes |
| <a name="input_minimum_origins"></a> [minimum\_origins](#input\_minimum\_origins) | The minimum number of origins that must be healthy for the pool to serve traffic. If the number of healthy origins falls within this number, the pool will be marked unhealthy and we will failover to the next available pool | `number` | n/a | yes |
| <a name="input_notification_email"></a> [notification\_email](#input\_notification\_email) | The Email address to send health status notifications to. This can be an individual mailbox or a mailing list. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this script. | `string` | n/a | yes |
| <a name="input_region1"></a> [region1](#input\_region1) | Please enter a region from the following available region and zones mapping: <br>us-south<br>us-east<br>eu-gb<br>eu-de<br>jp-tok<br>au-syd | `string` | n/a | yes |
| <a name="input_region1_pool_weight"></a> [region1\_pool\_weight](#input\_region1\_pool\_weight) | The origin pool-1 weight. | `number` | n/a | yes |
| <a name="input_region2"></a> [region2](#input\_region2) | Please enter a region from the following available region and zones mapping: <br>us-south<br>us-east<br>eu-gb<br>eu-de<br>jp-tok<br>au-syd | `string` | n/a | yes |
| <a name="input_region2_pool_weight"></a> [region2\_pool\_weight](#input\_region2\_pool\_weight) | The origin pool-2 weight. | `number` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID | `string` | n/a | yes |
| <a name="input_retries"></a> [retries](#input\_retries) | The number of retries to attempt in case of a timeout before marking the origin as unhealthy | `number` | n/a | yes |
| <a name="input_web_lb_ip_region1"></a> [web\_lb\_ip\_region1](#input\_web\_lb\_ip\_region1) | Web Load balancer public IP of region 1 to be used in origin pool of global load balancer | `string` | n/a | yes |
| <a name="input_web_lb_ip_region2"></a> [web\_lb\_ip\_region2](#input\_web\_lb\_ip\_region2) | Web Load balancer public IP of region 2 to be used in origin pool of global load balancer | `string` | n/a | yes |

## Outputs

No outputs.
