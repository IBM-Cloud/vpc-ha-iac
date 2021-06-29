# Overview
This use case builds the following in a single MZR.  A single VSI is created across 3 diffferent zones
and for each tier, totally 9 VSIs, and in their respective subnets and security groups. In addition,
another VSI, bastion server, is created for VSIs access and management.  Load balancers are created for
each tier to help distribute incoming requests.

**Note: You change the VSI count to increase the number of total VSIs for the application which also may
mean increasing the subnet count. Pluse you will also need to modify the security groups and load balancers
policies to match your application requirements.

* Resource Count for this project:
* VPC Count             = 1
* Subnet Count          = 10
* Security Group Count  = 3
* Security Group Rule   = 5
* Load Balancers        = 3

<img src="./images/3-tier-app-MZR_v2.jpg"/>


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | >= 1.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/instances |  |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | ./modules/load_balancers |  |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | ./modules/security_groups |  |
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnets |  |

## Resources

| Name | Type |
|------|------|
| [ibm_is_vpc.vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpc) | resource |
| [ibm_is_ssh_key.ssh_key_id](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/is_ssh_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | Please enter the IBM Cloud API key. | `string` | n/a | yes |
| <a name="input_ip_count"></a> [ip\_count](#input\_ip\_count) | Enter total number of IP Address for each subnet | `any` | `32` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This is the prefix text that will be prepended in every resource name created by this script. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Please enter a region from the following available region and zones mapping: <br>us-south<br>us-east<br>eu-gb<br>eu-de<br>jp-tok<br>au-syd | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource Group: | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | Enter your IBM cloud ssh key name. | `string` | n/a | yes |
| <a name="input_total_instance"></a> [total\_instance](#input\_total\_instance) | Total instances that will be created per zones per tier. | `number` | `1` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Region and zones mapping | `map(any)` | <pre>{<br>  "au-syd": [<br>    "au-syd-1",<br>    "au-syd-2",<br>    "au-syd-3"<br>  ],<br>  "eu-de": [<br>    "eu-de-1",<br>    "eu-de-2",<br>    "eu-de-3"<br>  ],<br>  "eu-gb": [<br>    "eu-gb-1",<br>    "eu-gb-2",<br>    "eu-gb-3"<br>  ],<br>  "jp-tok": [<br>    "jp-tok-1",<br>    "jp-tok-2",<br>    "jp-tok-3"<br>  ],<br>  "us-east": [<br>    "us-east-1",<br>    "us-east-2",<br>    "us-east-3"<br>  ],<br>  "us-south": [<br>    "us-south-1",<br>    "us-south-2",<br>    "us-south-3"<br>  ]<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb-app-dns"></a> [lb-app-dns](#output\_lb-app-dns) | n/a |
| <a name="output_lb-app-ip"></a> [lb-app-ip](#output\_lb-app-ip) | n/a |
| <a name="output_lb-db-dns"></a> [lb-db-dns](#output\_lb-db-dns) | n/a |
| <a name="output_lb-db-ip"></a> [lb-db-ip](#output\_lb-db-ip) | n/a |
| <a name="output_lb-web-dns"></a> [lb-web-dns](#output\_lb-web-dns) | n/a |
| <a name="output_lb-web-ip"></a> [lb-web-ip](#output\_lb-web-ip) | n/a |
| <a name="output_vsi-app-ips"></a> [vsi-app-ips](#output\_vsi-app-ips) | n/a |
| <a name="output_vsi-bastion-ip"></a> [vsi-bastion-ip](#output\_vsi-bastion-ip) | n/a |
| <a name="output_vsi-db-ips"></a> [vsi-db-ips](#output\_vsi-db-ips) | n/a |
| <a name="output_vsi-web-ips"></a> [vsi-web-ips](#output\_vsi-web-ips) | n/a |
