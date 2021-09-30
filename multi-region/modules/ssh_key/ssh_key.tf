/**
#################################################################################################################
*                      Resources Section of the SSH key data sources Module
#################################################################################################################
*/

# /**
# * Data Resource
# * Element : SSH Key
# * This will return the ssh key id of the Bastion-ssh-key. This is the dynamically generated ssh key from bastion-1 server itself.
# * This key will be attached to all the app servers.
# **/

data "ibm_is_ssh_key" "bastion1_key_id" {
  name = var.bastion1_key
}

# /**
# * Data Resource
# * Element : SSH Key
# * This will return the ssh key id of the Bastion-ssh-key. This is the dynamically generated ssh key from bastion-2 server itself.
# * This key will be attached to all the app servers.
# **/

data "ibm_is_ssh_key" "bastion2_key_id" {
  name = var.bastion2_key
}
