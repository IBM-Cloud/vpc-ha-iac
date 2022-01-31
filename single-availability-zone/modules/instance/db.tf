/**
#################################################################################################################
*                           Virtual Server Instance Section for the DB Instance Module.
*                                 Start Here for the Resources Section 
#################################################################################################################
*/

/**
* Data Volume for DB servers
* Element : volume
* This extra storage volume will be attached to the DB servers as per the user specified size and bandwidth
**/
resource "ibm_is_volume" "data_volume" {
  count          = var.db_vsi_count
  name           = "${var.prefix}volume-${count.index + 1}-${var.zone}"
  resource_group = var.resource_group_id
  profile        = var.tiered_profiles[var.bandwidth]
  zone           = var.zone
  capacity       = var.data_vol_size
}

/**
* Virtual Server Instance for DB
* Element : VSI
* This resource will be used to create a DB VSI as per the user input.
**/
resource "ibm_is_instance" "db" {
  count           = var.db_vsi_count
  name            = "${var.prefix}db-vsi-${count.index + 1}-${var.zone}"
  keys            = var.ssh_key
  image           = var.db_image
  profile         = var.db_profile
  resource_group  = var.resource_group_id
  vpc             = var.vpc_id
  zone            = var.zone
  placement_group = var.db_placement_group_id
  depends_on      = [var.db_sg]
  volumes         = [ibm_is_volume.data_volume.*.id[count.index]]

  primary_network_interface {
    subnet          = var.subnet
    security_groups = [var.db_sg]
  }
}
