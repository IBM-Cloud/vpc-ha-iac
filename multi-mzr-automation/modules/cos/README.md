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
| [ibm_cos_bucket.cos_bucket](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cos_bucket) | resource |
| [ibm_cos_bucket_object.cos_object](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cos_bucket_object) | resource |
| [ibm_resource_instance.cos_instance](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/resource_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | The location of the COS bucket | `string` | n/a | yes |
| <a name="input_cos_bucket_plan"></a> [cos\_bucket\_plan](#input\_cos\_bucket\_plan) | Please enter plan name for COS bucket. Possible value is <br>1:lite<br>2:standard | `string` | n/a | yes |
| <a name="input_cross_region_location"></a> [cross\_region\_location](#input\_cross\_region\_location) | Cross Region service provides higher durability and availability than using a single region, at the cost of slightly higher latency. This service is available today in the U.S., E.U., and A.P. areas. | `string` | n/a | yes |
| <a name="input_obj_content"></a> [obj\_content](#input\_obj\_content) | Literal string value to use as an object content, which will be uploaded as UTF-8 encoded text. Conflicts with content\_base64 and content\_file | `string` | n/a | yes |
| <a name="input_obj_key"></a> [obj\_key](#input\_obj\_key) | The name of an object in the COS bucket. This is used to identify our object. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all the resources. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource Group ID is used to seperate the resources in a group. | `string` | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Storage class helps in choosing a right storage plan and location and helps in reducing the cost. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_object_endpoint"></a> [object\_endpoint](#output\_object\_endpoint) | n/a |
