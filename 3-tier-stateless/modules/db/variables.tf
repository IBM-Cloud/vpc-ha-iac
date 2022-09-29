/**
#################################################################################################################
*                           Variable Section for the db Module.
*                           Start Here of the Variable Section 
#################################################################################################################
*/

/**
* Name: resource_group_id
* Type: String
* Description: Resource Group ID to be used for resources creation
*/
variable "resource_group_id" {
  description = "Resource Group ID"
  type        = string
}

/**
* Name: prefix
* Type: String
* Description: This is the prefix text that will be prepended in every resource name created by this script.
**/
variable "prefix" {
  description = "Prefix for all the resources."
  type        = string
}

/**
* Name: region
* Type: String
* Description: Region to be used for resources creation
*/
variable "region" {
  description = "Please enter a region from the following available region and zones mapping: \nus-south\nus-east\neu-gb\neu-de\njp-tok\nau-syd"
  type        = string
}

/**
* Name: db_version
* Type: String
* Description: The database version to provision if specified
*/
variable "db_version" {
  type        = string
  description = "The database version to provision if specified"
}

/**
* Name: db_admin_password
* Type: String
* Description: The admin user password for the Database service instance
*/
variable "db_admin_password" {
  type        = string
  description = "The admin user password for the Database service instance"
}

/**
* Name: service
* Type: String
* Description: The type of Cloud Databases that you want to create.
*/
variable "service" {
  type        = string
  description = "The type of Cloud Databases that you want to create."
}

/**
* Name: service_endpoints
* Type: String
* Description: Allowed network of database instance. It could be 'private', 'public' or 'public-and-private'.
*/
variable "service_endpoints" {
  description = "Allowed network of database instance. It could be 'private', 'public' or 'public-and-private'."
  type        = string
}

/**
* Name: plan
* Type: string
* Description: The name of the service plan that you choose for your instance. All databases use 'standard'. The 'enterprise' is supported only for cassandra (databases-for-cassandra) and mongodb(databases-for-mongodb)
*/
variable "plan" {
  type        = string
  description = "The name of the service plan that you choose for your instance. All databases use 'standard'. The 'enterprise' is supported only for cassandra (databases-for-cassandra) and mongodb(databases-for-mongodb)"
}

/**
* Name: member_cpu_allocation_count
* Type: number
* Description: Enables and allocates dedicated CPU per-member to your deployment.
*/
variable "member_cpu_allocation_count" {
  type        = number
  description = "Enables and allocates dedicated CPU per-member to your deployment."
}

/**
* Name: member_disk_allocation_mb
* Type: number
* Description: The amount of disk space for the database, allocated per-member.
*/
variable "member_disk_allocation_mb" {
  type        = number
  description = "The amount of disk space for the database, allocated per-member."
}

/**
* Name: member_memory_allocation_mb
* Type: number
* Description: The amount of memory in megabytes for the database, allocated per-member.
*/
variable "member_memory_allocation_mb" {
  type        = number
  description = "The amount of memory in megabytes for the database, allocated per-member."
}

/**
* Name: create_timeout
* Type: String
* Description: The creation of an instance is considered failed when no response is received for create_timeout minutes.
*/
variable "create_timeout" {
  type        = string
  description = "The creation of an instance is considered failed when no response is received for create_timeout minutes."
}

/**
* Name: update_timeout
* Type: String
* Description: The update of an instance is considered failed when no response is received for update_timeout minutes.
*/
variable "update_timeout" {
  type        = string
  description = "The update of an instance is considered failed when no response is received for update_timeout minutes."
}

/**
* Name: delete_timeout
* Type: String
* Description: The deletion of an instance is considered failed when no response is received for delete_timeout minutes.
*/
variable "delete_timeout" {
  type        = string
  description = "The deletion of an instance is considered failed when no response is received for delete_timeout minutes."
}

/**
* Name: users
* Type: set(map(string))
* Description: Database Users. It is set of username and passwords
*/
variable "users" {
  type        = set(map(string))
  description = "Database Users. It is set of username and passwords"
}

/**
* Name: whitelist
* Type: set(map(string))
* Description: Database Whitelist It is set of IP Address and description
*/
variable "whitelist" {
  type        = set(map(string))
  description = "Database Whitelist It is set of IP Address and description"
}

/**
* Name: tags
* Type: String
* Description: Tags added to the database instance
*/
variable "tags" {
  description = "Tags added to the database instance"
  type        = set(string)
}

/**
* Name: key_protect_instance
* Type: String
* Description: The instance CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
*/
variable "key_protect_instance" {
  type        = string
  description = "The instance CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption."
}

/**
* Name: key_protect_key
* Type: String
* Description: The root key CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
*/
variable "key_protect_key" {
  type        = string
  description = "The root key CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption."
}

/**
* Name: auto_scaling
* Type: set(map(string))
* Description: Configure rules to allow your database to automatically increase its resources. Single block of autoscaling is allowed at once.
*/
variable "auto_scaling" {
  description = "Configure rules to allow your database to automatically increase its resources. Single block of autoscaling is allowed at once."
  type        = set(map(string))
}

/**
* Name: backup_id
* Type: String
* Description: The CRN of a backup resource to restore from. The backup is created by a database deployment with the same service ID. The backup is loaded after provisioning and the new deployment starts up that uses that data. If omitted, the database is provisioned empty.
*/
variable "backup_id" {
  description = "The CRN of a backup resource to restore from. The backup is created by a database deployment with the same service ID. The backup is loaded after provisioning and the new deployment starts up that uses that data. If omitted, the database is provisioned empty."
  type        = string
}

/**
* Name: backup_encryption_key_crn
* Type: String
* Description: The CRN of a key protect key, that you want to use for encrypting disk that holds deployment backups.
*/
variable "backup_encryption_key_crn" {
  description = "The CRN of a key protect key, that you want to use for encrypting disk that holds deployment backups."
  type        = string
}

/**
* Name: remote_leader_id
* Type: String
* Description: A CRN of the leader database to make the replica(read-only) deployment. The leader database is created by a database deployment with the same service ID.
*/
variable "remote_leader_id" {
  type        = string
  description = "A CRN of the leader database to make the replica(read-only) deployment. The leader database is created by a database deployment with the same service ID."
}

/**
#################################################################################################################
*                               End of the Variable Section 
#################################################################################################################
**/
