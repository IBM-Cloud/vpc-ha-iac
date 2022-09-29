# ###################################################################################################
# ###################################################################################################
# #####           This Terraform file defines the variables used in dbaas Module               ######
# #####                                       db Module                                     ######
# ###################################################################################################
# ###################################################################################################

locals {
  service                     = "databases-for-mysql" # The type of Cloud Databases that you want to create. Currently support for only 'databases-for-mysql'.
  plan                        = "standard"            # The name of the service plan that you choose for your instance. All databases use 'standard'. The 'enterprise' is supported only for cassandra and mongodb
  db_version                  = "5.7"                 # The database version for the mysql dbaas service
  create_timeout              = "1h"                  #The creation of an instance is considered failed when no response is received for create_timeout minutes.
  update_timeout              = "1h"                  #The update of an instance is considered failed when no response is received for update_timeout minutes.
  delete_timeout              = "15m"                 #The deletion of an instance is considered failed when no response is received for delete_timeout minutes.
  member_cpu_allocation_count = 3                     # Enables and allocates dedicated CPU per-member to your deployment. Member group cpu must be >= 3 and <= 28 in increments of 1.
  member_disk_allocation_mb   = 20480                 # The amount of disk space for the database, allocated per-member. Member group disk must be >= 20480 and <= 4194304 in increments of 1024.
  member_memory_allocation_mb = 1024                  # The amount of memory in megabytes for the database, allocated per-member. Member group memory must be >= 1024 and <= 114688 in increments of 128.
  users                       = null                  # Type = set(map(string)), Database Users. It is set of username and passwords example: [{ "name"= "" "password" = ""}, { "name"= "" "password" = ""}] 
  whitelist                   = null                  # Type = set(map(string)), Database Whitelist It is set of IP Address and description, example: [{ "address"= "10.248.0.4/32" "description" = ""}, { "address"= "10.248.64.4/32" "description" = ""}] 
  tags                        = null                  # Type = set(string), Tags to the dbaas service, example : ["tag1", "tag2"]
  key_protect_instance        = null                  # The instance CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
  key_protect_key             = null                  # The root key CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
  backup_id                   = null                  # The CRN of a backup resource to restore from. The backup is created by a database deployment with the same service ID.
  backup_encryption_key_crn   = null                  # The CRN of a key protect key, that you want to use for encrypting disk that holds deployment backups.
  auto_scaling                = null                  # Type = set(map(string)), Configure rules to allow your database to automatically increase its resources. Single block of autoscaling is allowed at once.
  remote_leader_id            = null                  # A CRN of the leader database to make the replica(read-only) deployment. The leader database is created by a database deployment with the same service ID.
}

/**
* Name: db_access_endpoints
* Type: String
* Description: Allowed network of database instance. It could be 'private', 'public' or 'public-and-private'.
*/
variable "db_access_endpoints" {
  description = "Allowed network of database instance"
  type        = string
  default     = "private"
}