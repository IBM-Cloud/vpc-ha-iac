/**
#################################################################################################################
*                           Resources Section for the db Module.
#################################################################################################################
*/

/**
* IBM Cloud Database
* Element : ibm_database
* This resource will be used to create a database as per the users input.
**/
resource "ibm_database" "db" {
  name              = "${var.prefix}db"
  resource_group_id = var.resource_group_id
  location          = var.region
  version           = var.db_version
  adminpassword     = var.db_admin_password
  service           = var.service
  service_endpoints = var.service_endpoints
  plan              = var.plan
  group {
    group_id = "member"
    memory {
      allocation_mb = var.member_memory_allocation_mb
    }
    disk {
      allocation_mb = var.member_disk_allocation_mb
    }
    cpu {
      allocation_count = var.member_cpu_allocation_count
    }
  }
  key_protect_instance      = var.key_protect_instance
  key_protect_key           = var.key_protect_key
  tags                      = var.tags
  backup_id                 = var.backup_id
  backup_encryption_key_crn = var.backup_encryption_key_crn
  remote_leader_id          = var.remote_leader_id
  auto_scaling {}
  dynamic "users" {
    for_each = (var.users != null ? var.users : [])
    content {
      name     = (users.value.name != "" ? users.value.name : null)
      password = (users.value.password != "" ? users.value.password : null)
    }
  }
  dynamic "whitelist" {
    for_each = (var.whitelist != null ? var.whitelist : [])
    content {
      address     = (whitelist.value.address != "" ? whitelist.value.address : null)
      description = (whitelist.value.description != "" ? whitelist.value.description : null)
    }
  }
  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}