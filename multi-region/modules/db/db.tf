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
  dynamic "auto_scaling" {
    for_each = (var.auto_scaling != null ? var.auto_scaling : [])
    content {
      disk {
        capacity_enabled             = auto_scaling.value.disk.capacity_enabled
        free_space_less_than_percent = auto_scaling.value.disk.free_space_less_than_percent
        io_above_percent             = auto_scaling.value.disk.io_above_percent
        io_enabled                   = auto_scaling.value.disk.io_enabled
        io_over_period               = auto_scaling.value.disk.io_over_period
        rate_increase_percent        = auto_scaling.value.disk.rate_increase_percent
        rate_limit_mb_per_member     = auto_scaling.value.disk.rate_limit_mb_per_member
        rate_period_seconds          = auto_scaling.value.disk.rate_period_seconds
        rate_units                   = auto_scaling.value.disk.rate_units
      }
      memory {
        io_above_percent         = auto_scaling.value.memory.io_above_percent
        io_enabled               = auto_scaling.value.memory.io_enabled
        io_over_period           = auto_scaling.value.memory.io_over_period
        rate_increase_percent    = auto_scaling.value.memory.rate_increase_percent
        rate_limit_mb_per_member = auto_scaling.value.memory.rate_limit_mb_per_member
        rate_period_seconds      = auto_scaling.value.memory.rate_period_seconds
        rate_units               = auto_scaling.value.memory.rate_units
      }
    }
  }
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