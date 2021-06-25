/**
#################################################################################################################
*                           Resources Section for the Bastion Module.
#################################################################################################################
*/

/**
* Virtual Server Instance for Bastion Server or Jump Server
* Element : VSI
* We are creating a bastion server or jump server along with the floating IP. The bastion server is mainly used to maintain the server and other 
* cloud resources within the same VPC. It is used to secure other servers to only allow access from bastion server. 
* For this, we will generate a ssh_key on the bastion server dynamically as part of its user data. And will use the public key contents of this 
* same generated key to create the bastion-ssh-key on IBM Cloud. And this bastion-ssh-key will be attached to all other VSI. 
* This is will ensure the server access only from the Bastion.

* As this bastion server is very important to access other VSI. So to prevent the accidental 
* deletion of this server we are adding a lifecycle block with prevent_destroy=true flag to 
* protect this. If you want to delete this server then before executing terraform destroy, please update prevent_destroy=false.
**/
resource "ibm_is_instance" "bastion" {
  name           = "${var.prefix}bastion-vsi"
  keys           = var.user_ssh_key
  image          = var.bastion_image
  profile        = var.bastion_profile
  resource_group = var.resource_group_id
  vpc            = var.vpc_id
  zone           = var.zones[0]
  user_data      = <<-EOUD
    #!/bin/bash
        ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa 2>&1 >/dev/null
    EOUD

  primary_network_interface {
    subnet          = var.subnet
    security_groups = [var.security_group_id]
  }
  lifecycle {
    prevent_destroy = true
  }
  depends_on = [var.security_group_id]
}

/**
* Floating IP address for Bastion Server or Jump Server. This is the static public IP attached to the bastion server. User will use this floating IP to ssh connect to the 
* bastion server from their local machine.
* Element : Floating IP
* This resource will be used to attach a floating IP address.
**/
resource "ibm_is_floating_ip" "bastion_floating_ip" {
  name           = "${var.prefix}bastion-fip"
  resource_group = var.resource_group_id
  target         = ibm_is_instance.bastion.primary_network_interface.0.id
  depends_on     = [ibm_is_instance.bastion]
}

/**
* This block is for time sleep once bastion server is ready. 
* Element : Wait for 60 seconds
* Before scp command to copy the public file from bastion to our local machine, we need to wait for sometime so that bastion server can come in ready state.
**/
resource "time_sleep" "wait_60_seconds" {
  depends_on      = [ibm_is_floating_ip.bastion_floating_ip]
  create_duration = "60s"
}

/**
* Element : Local Executioner
* This local-exec block will be used to copy id_rsa.pub key file from bastion server to our local machine in key folder.
**/
resource "null_resource" "copy_ssh_key" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p key
      scp -o StrictHostKeyChecking=no root@${ibm_is_floating_ip.bastion_floating_ip.address}:/root/.ssh/id_rsa.pub key/
    EOT
  }
  depends_on = [ibm_is_floating_ip.bastion_floating_ip, time_sleep.wait_60_seconds]
}

/**
* This data block will read the contents of id_rsa.pub key file which we copied from bastion server to local. And will pass to the ibm_is_ssh_key.iac_shared_ssh_key resource.
* This public file contents will be uploaded to IBM cloud on creation of the bastion-ssh-key. This bastion-ssh-key will be attached to App/Web/DB servers and will then be used 
* to login from Bastion server to the other App/Web/DB servers.
**/

data "local_file" "input" {
  filename = "key/id_rsa.pub"
  depends_on = [
    null_resource.copy_ssh_key,
  ]
}

/**
* SSH-Key for app/web/db servers
* Element : SSH-Key
* This bastion-ssh-key will be attached to the app/web/db servers. Since the private key file of this key pair is only in the bastion server.
* This will ensure that we can ssh connect to these app/web/db servers from Bastion server only.
**/

resource "ibm_is_ssh_key" "iac_shared_ssh_key" {
  name           = "${var.prefix}${var.bastion_ssh_key}"
  resource_group = var.resource_group_id
  public_key     = data.local_file.input.content
  lifecycle {
    ignore_changes = [
      public_key,
    ]
  }
}
