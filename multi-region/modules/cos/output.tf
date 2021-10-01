/**
#################################################################################################################
*                                 COS Bucket Output Variable Section
#################################################################################################################
**/

/**
* Output Variable
* Element : COS Public and Private endpoint
* This variable will return the public and private end points for the COS bucket.
**/
output "object_endpoint" {
  value = merge(
    { "PRI_ENDPOINT" = "${ibm_cos_bucket.cos_bucket.s3_endpoint_private}/${ibm_cos_bucket.cos_bucket.bucket_name}/${ibm_cos_bucket_object.cos_object.key}" },
    { "PUB_ENDPOINT" = "${ibm_cos_bucket.cos_bucket.s3_endpoint_public}/${ibm_cos_bucket.cos_bucket.bucket_name}/${ibm_cos_bucket_object.cos_object.key}" }
  )
}
