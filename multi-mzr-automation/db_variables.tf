###################################################################################################
###################################################################################################
#####           This Terraform file defines the variables used in dbaas Module               ######
#####                                       db Module                                     ######
###################################################################################################
###################################################################################################

locals {
  service_region_1                     = "databases-for-mysql" # The type of Cloud Databases that you want to create. Currently support for only 'databases-for-mysql'.
  plan_region_1                        = "standard"            # The name of the service plan that you choose for your instance. All databases use 'standard'. The 'enterprise' is supported only for cassandra and mongodb
  db_version_region_1                  = "5.7"                 # The database version for the mysql dbaas service
  member_cpu_allocation_count_region_1 = 3                     # Enables and allocates dedicated CPU per-member to your deployment. Member group cpu must be >= 3 and <= 28 in increments of 1.
  member_disk_allocation_mb_region_1   = 20480                 # The amount of disk space for the database, allocated per-member. Member group disk must be >= 20480 and <= 4194304 in increments of 1024.
  member_memory_allocation_mb_region_1 = 1024                  # The amount of memory in megabytes for the database, allocated per-member. Member group memory must be >= 1024 and <= 114688 in increments of 128.
  users_region_1                       = null                  # Type = set(map(string)), Database Users. It is set of username and passwords example: [{ "name"= "" "password" = ""}, { "name"= "" "password" = ""}] 
  create_timeout_region_1              = "1h"                  # The creation of an instance is considered failed when no response is received for create_timeout minutes.
  update_timeout_region_1              = "1h"                  # The update of an instance is considered failed when no response is received for update_timeout minutes.
  delete_timeout_region_1              = "15m"                 # The deletion of an instance is considered failed when no response is received for delete_timeout minutes.
  auto_scaling_region_1 = [{                                   # Type = set(map(string)), Configure rules to allow your database to automatically increase its resources. Single block of autoscaling is allowed at once.
    /**
    *  Autoscale Disk: 
    *  note -> [Disk cannot be scaled down] 
    *  Perform autoscaling:  [When to scale, based on usage over a period of time]
    *  When either
    *  -> Average I/O utilisation is above <io_above_percent> over a <io_over_period> period 
    *  or 
    *  -> when less than <free_space_less_than_percent> free space is remaining
    *  Then
    *  Scale up by <rate_increase_percent> every <rate_period_seconds> to a limit of <rate_limit_mb_per_member> per member
    *  [ A hard limit on scaling, the deployment stops scaling at the limit ]
    */
    "disk" = {
      "capacity_enabled"             = true    # (Optional, Bool) Auto scaling scalar enables or disables the scalar capacity.
      "free_space_less_than_percent" = 15      # (Optional, Integer) Auto scaling scalar capacity free space less than percent.
      "io_above_percent"             = 85      # (Optional, Integer) Auto scaling scalar I/O utilization above percent.
      "io_enabled"                   = true    # (Optional, String) Auto scaling scalar I/O utilization over period. 
      "io_over_period"               = "15m"   # (Optional, Bool) Auto scaling scalar I/O utilization enabled.
      "rate_increase_percent"        = 15      # (Optional, Integer) Auto scaling rate increase percent.
      "rate_limit_mb_per_member"     = 3670016 # (Optional, Integer) Auto scaling rate limit in megabytes per member. Max limit is 3TB.
      "rate_period_seconds"          = 900     # (Optional, Integer) Auto scaling rate period in seconds.
      "rate_units"                   = "mb"    # (Optional, String) Auto scaling rate in units.
    }
    /**
    *  Autoscale Memory/RAM : 
    *  Perform autoscaling:  
    *  When [When to scale, based on usage over a period of time]
    *  -> Average I/O utilisation is above <io_above_percent> over a <io_over_period> period 
    *  Then
    *  Scale up by <rate_increase_percent> every <rate_period_seconds> to a limit of <rate_limit_mb_per_member> per member
    *  [ A hard limit on scaling, the deployment stops scaling at the limit ]
    */
    "memory" = {
      "io_above_percent"         = 90     # (Optional, Integer) Auto scaling scalar I/O utilization above percent.
      "io_enabled"               = true   # (Optional) Auto scaling scalar I/O utilization enabled.
      "io_over_period"           = "15m"  # (Optional, String) Auto scaling scalar I/O utilization over period.  
      "rate_increase_percent"    = 10     # (Optional, Integer) Auto scaling rate in increase percent.
      "rate_limit_mb_per_member" = 114688 # (Optional, Integer) Auto scaling rate limit in megabytes per member. Max limit is 114688MB which is 112GB.
      "rate_period_seconds"      = 900    # (Optional, Integer) Auto scaling rate period in seconds.
      "rate_units"               = "mb"   # (Optional, String) Auto scaling rate in units.
    }
    }
  ]
  whitelist_region_1                 = null # Type = set(map(string)), Database Whitelist It is set of IP Address and description, example: [{ "address"= "10.248.0.4/32" "description" = ""}, { "address"= "10.248.64.4/32" "description" = ""}] 
  tags_region_1                      = null # Type = set(string), Tags to the dbaas service, example : ["tag1", "tag2"]
  key_protect_instance_region_1      = null # The instance CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
  key_protect_key_region_1           = null # The root key CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
  backup_id_region_1                 = null # The CRN of a backup resource to restore from. The backup is created by a database deployment with the same service ID.
  backup_encryption_key_crn_region_1 = null # The CRN of a key protect key, that you want to use for encrypting disk that holds deployment backups.
  remote_leader_id_region_1          = null # A CRN of the leader database to make the replica(read-only) deployment. The leader database is created by a database deployment with the same service ID.
}

/**
* Name: db_admin_password
* Type: String
* Description: The admin user password for the Database service instance. No special characters; minimum 10 characters, A-Z, a-z, 0-9
*/
variable "db_admin_password" {
  type        = string
  description = "The admin user password for the Database service instance. No special characters; minimum 10 characters, A-Z, a-z, 0-9"
}

/**
* Name: db_access_endpoints_region_1
* Type: String
* Description: Allowed network of database instance in region 1. It could be 'private', 'public' or 'public-and-private'.
*/
variable "db_access_endpoints_region_1" {
  description = "Allowed network of database instance in region 1"
  type        = string
  default     = "private"
}

/**
* Name: db_enable_autoscaling_region_1
* Type: String
* Description: Enable db autoscaling in region 1 
*/
variable "db_enable_autoscaling_region_1" {
  description = "Enable db autoscaling in region 1."
  type        = bool
  default     = false
}

locals {
  service_region_2                     = "databases-for-mysql" # The type of Cloud Databases that you want to create. Currently support for only 'databases-for-mysql'.
  plan_region_2                        = "standard"            # The name of the service plan that you choose for your instance. All databases use 'standard'. The 'enterprise' is supported only for cassandra and mongodb
  db_version_region_2                  = "5.7"                 # The database version for the mysql dbaas service
  member_cpu_allocation_count_region_2 = 3                     # Enables and allocates dedicated CPU per-member to your deployment. Member group cpu must be >= 3 and <= 28 in increments of 1.
  member_disk_allocation_mb_region_2   = 20480                 # The amount of disk space for the database, allocated per-member. Member group disk must be >= 20480 and <= 4194304 in increments of 1024.
  member_memory_allocation_mb_region_2 = 1024                  # The amount of memory in megabytes for the database, allocated per-member. Member group memory must be >= 1024 and <= 114688 in increments of 128.
  users_region_2                       = null                  # Type = set(map(string)), Database Users. It is set of username and passwords example: [{ "name"= "" "password" = ""}, { "name"= "" "password" = ""}] 
  create_timeout_region_2              = "1h"                  # The creation of an instance is considered failed when no response is received for create_timeout minutes.
  update_timeout_region_2              = "1h"                  # The update of an instance is considered failed when no response is received for update_timeout minutes.
  delete_timeout_region_2              = "15m"                 # The deletion of an instance is considered failed when no response is received for delete_timeout minutes.
  auto_scaling_region_2 = [{                                   # Type = set(map(string)), Configure rules to allow your database to automatically increase its resources. Single block of autoscaling is allowed at once.
    /**
    *  Autoscale Disk: 
    *  note -> [Disk cannot be scaled down] 
    *  Perform autoscaling:  [When to scale, based on usage over a period of time]
    *  When either
    *  -> Average I/O utilisation is above <io_above_percent> over a <io_over_period> period 
    *  or 
    *  -> when less than <free_space_less_than_percent> free space is remaining
    *  Then
    *  Scale up by <rate_increase_percent> every <rate_period_seconds> to a limit of <rate_limit_mb_per_member> per member
    *  [ A hard limit on scaling, the deployment stops scaling at the limit ]
    */
    "disk" = {
      "capacity_enabled"             = true    # (Optional, Bool) Auto scaling scalar enables or disables the scalar capacity.
      "free_space_less_than_percent" = 15      # (Optional, Integer) Auto scaling scalar capacity free space less than percent.
      "io_above_percent"             = 85      # (Optional, Integer) Auto scaling scalar I/O utilization above percent.
      "io_enabled"                   = true    # (Optional, String) Auto scaling scalar I/O utilization over period. 
      "io_over_period"               = "15m"   # (Optional, Bool) Auto scaling scalar I/O utilization enabled.
      "rate_increase_percent"        = 15      # (Optional, Integer) Auto scaling rate increase percent.
      "rate_limit_mb_per_member"     = 3670016 # (Optional, Integer) Auto scaling rate limit in megabytes per member. Max limit is 3TB.
      "rate_period_seconds"          = 900     # (Optional, Integer) Auto scaling rate period in seconds.
      "rate_units"                   = "mb"    # (Optional, String) Auto scaling rate in units.
    }
    /**
    *  Autoscale Memory/RAM : 
    *  Perform autoscaling:  
    *  When [When to scale, based on usage over a period of time]
    *  -> Average I/O utilisation is above <io_above_percent> over a <io_over_period> period 
    *  Then
    *  Scale up by <rate_increase_percent> every <rate_period_seconds> to a limit of <rate_limit_mb_per_member> per member
    *  [ A hard limit on scaling, the deployment stops scaling at the limit ]
    */
    "memory" = {
      "io_above_percent"         = 90     # (Optional, Integer) Auto scaling scalar I/O utilization above percent.
      "io_enabled"               = true   # (Optional) Auto scaling scalar I/O utilization enabled.
      "io_over_period"           = "15m"  # (Optional, String) Auto scaling scalar I/O utilization over period.  
      "rate_increase_percent"    = 10     # (Optional, Integer) Auto scaling rate in increase percent.
      "rate_limit_mb_per_member" = 114688 # (Optional, Integer) Auto scaling rate limit in megabytes per member. Max limit is 114688MB which is 112GB.
      "rate_period_seconds"      = 900    # (Optional, Integer) Auto scaling rate period in seconds.
      "rate_units"               = "mb"   # (Optional, String) Auto scaling rate in units.
    }
    }
  ]
  whitelist_region_2                 = null # Type = set(map(string)), Database Whitelist It is set of IP Address and description, example: [{ "address"= "10.248.0.4/32" "description" = ""}, { "address"= "10.248.64.4/32" "description" = ""}] 
  tags_region_2                      = null # Type = set(string), Tags to the dbaas service, example : ["tag1", "tag2"]
  key_protect_instance_region_2      = null # The instance CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
  key_protect_key_region_2           = null # The root key CRN of a Key Management Services like Key Protect or Hyper Protect Crypto Service (HPCS) that you want to use for disk encryption.
  backup_id_region_2                 = null # The CRN of a backup resource to restore from. The backup is created by a database deployment with the same service ID.
  backup_encryption_key_crn_region_2 = null # The CRN of a key protect key, that you want to use for encrypting disk that holds deployment backups.
  remote_leader_id_region_2          = null # A CRN of the leader database to make the replica(read-only) deployment. The leader database is created by a database deployment with the same service ID.
}

/**
* Name: db_access_endpoints_region_2
* Type: String
* Description: Allowed network of database instance in region 2. It could be 'private', 'public' or 'public-and-private'.
*/
variable "db_access_endpoints_region_2" {
  description = "Allowed network of database instance in region 2"
  type        = string
  default     = "private"
}

/**
* Name: db_enable_autoscaling_region_2
* Type: String
* Description: Enable db autoscaling in region 2
*/
variable "db_enable_autoscaling_region_2" {
  description = "Enable db autoscaling in region 2."
  type        = bool
  default     = false
}
