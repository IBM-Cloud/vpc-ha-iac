/**
#################################################################################################################
*                           Resources Section for the Bastion Module.
#################################################################################################################
*/

# Using the datasource to get the tokens object 
data "ibm_iam_auth_token" "auth_token" {}

/**
* This local block is used to declare the local variables for linux and windows Bastion server userdata.
* In these Bastion server userdata, we are creating the bastion ssh keys on IBM cloud in both the regions. These ssh keys will then be attached 
* to the app/web/db servers. Thus only bastion server will have access to these servers of both the regions.
**/

locals {
  // This is the suffix name of the ssh key which will be created dynamically on the bastion VSI. 
  // So that, users can login to Web/App/DB servers via Bastion server only.
  bastion_ssh_key = "ssh-key"

  win_userdata = <<-EOUD
        Content-Type: text/x-shellscript; charset="us-ascii"
        MIME-Version: 1.0
        #ps1_sysnative
        mkdir C:\Users\Administrator\.ssh
        cd C:\Users\Administrator\.ssh
        ssh-keygen -t rsa -C "user_ID" -f "id_rsa" -P """"
        $date = Get-Date
        $cur_date = $date.ToString("yyyy-MM-dd")
        $oauth_token = "${data.ibm_iam_auth_token.auth_token.iam_access_token}"
        $contentType = "application/json"
        $pub_key = Get-Content "C:\Users\Administrator\.ssh\id_rsa.pub"
        $vpc_api_endpoint = "https://${var.region1}.iaas.cloud.ibm.com"
        $url = "$vpc_api_endpoint/v1/keys?version=$cur_date&generation=2"
        $headers = @{"Authorization" = "$oauth_token"}
        $body = ConvertTo-Json @{
          name = "${var.prefix}${local.bastion_ssh_key}";
          resource_group = @{id = "${var.resource_group_id}"};
          public_key = "$pub_key";
          type = "rsa"
        }
        Invoke-WebRequest $url -Headers $headers -ContentType $contentType -Body $body -Method POST
        $vpc_api_endpoint = "https://${var.region2}.iaas.cloud.ibm.com"
        $url = "$vpc_api_endpoint/v1/keys?version=$cur_date&generation=2"
        $headers = @{"Authorization" = "$oauth_token"}
        $body = ConvertTo-Json @{
          name = "${var.prefix}${local.bastion_ssh_key}";
          resource_group = @{id = "${var.resource_group_id}"};
          public_key = "$pub_key";
          type = "rsa"
        }
        Invoke-WebRequest $url -Headers $headers -ContentType $contentType -Body $body -Method POST
        mkdir C:\Users\cloudbase-init\IBM_Cloud_CLI
        cd C:\Users\cloudbase-init
        Invoke-WebRequest https://download.clis.cloud.ibm.com/ibm-cloud-cli/2.0.2/binaries/IBM_Cloud_CLI_2.0.2_windows_amd64.zip -OutFile "C:\Users\cloudbase-init\IBM_Cloud_CLI_2.0.2_windows_amd64.zip"
        Expand-Archive -Path "C:\Users\cloudbase-init\IBM_Cloud_CLI_2.0.2_windows_amd64.zip" -DestinationPath "C:\Users\cloudbase-init"
        C:\Users\cloudbase-init\IBM_Cloud_CLI\ibmcloud.exe config --check-version=false
        C:\Users\cloudbase-init\IBM_Cloud_CLI\ibmcloud.exe plugin install vpc-infrastructure     
      EOUD

  lin_userdata = <<-EOUD
        #!/bin/bash
        ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa  2>&1 >/dev/null
        cur_date=$(date "+%Y-%m-%d")
        pub_key=`cat ~/.ssh/id_rsa.pub`
        export oauth_token="${data.ibm_iam_auth_token.auth_token.iam_access_token}"
        vpc_api_endpoint="https://${var.region1}.iaas.cloud.ibm.com"
        curl -X POST "$vpc_api_endpoint/v1/keys?version=$cur_date&generation=2" -H "Authorization: $oauth_token" -d '{
            "name":"${var.prefix}${local.bastion_ssh_key}",
            "resource_group":{"id":"${var.resource_group_id}"},
            "public_key":"'"$pub_key"'",
            "type":"rsa"
        }'
        vpc_api_endpoint="https://${var.region2}.iaas.cloud.ibm.com"
        curl -X POST "$vpc_api_endpoint/v1/keys?version=$cur_date&generation=2" -H "Authorization: $oauth_token" -d '{
            "name":"${var.prefix}${local.bastion_ssh_key}",
            "resource_group":{"id":"${var.resource_group_id}"},
            "public_key":"'"$pub_key"'",
            "type":"rsa"
        }'
        curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash
        ibmcloud plugin install vpc-infrastructure
        EOUD   
}

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
  name           = "${var.prefix}vsi"
  keys           = var.user_ssh_key
  image          = var.bastion_image
  profile        = var.bastion_profile
  resource_group = var.resource_group_id
  vpc            = var.vpc_id
  zone           = var.zones[0]
  user_data      = lower(var.bastion_os_type) == "windows" ? local.win_userdata : local.lin_userdata

  primary_network_interface {
    subnet          = ibm_is_subnet.bastion_sub.id
    security_groups = [ibm_is_security_group.bastion.id]
  }
  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      user_data,
    ]
  }
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
* Element : Wait for few seconds
**/

resource "time_sleep" "wait_240_seconds" {
  depends_on      = [ibm_is_floating_ip.bastion_floating_ip]
  create_duration = "240s"
}

/**
* This null resource block is for deleting the dynamic ssh key generated via bastion server. This will execute on terraform destroy. 
* Element : delete_dynamic_ssh_key
* This block is for those users who has Linux/Mac as their local machines.
**/

resource "null_resource" "delete_dynamic_ssh_key" {
  count = lower(var.local_machine_os_type) == "windows" ? 0 : 1

  triggers = {
    region1         = var.region1
    region2         = var.region2
    api_key         = var.api_key
    prefix          = var.prefix
    bastion_ssh_key = local.bastion_ssh_key
    floating_ip     = ibm_is_floating_ip.bastion_floating_ip.address
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      echo 'connection success'
      ibmcloud config --check-version=false
      ibmcloud login -r ${self.triggers.region1} --apikey ${self.triggers.api_key}
      key_id=$(ibmcloud is keys | grep ${self.triggers.prefix}${self.triggers.bastion_ssh_key} | awk '{print $1}')
      if [ ! -z "$key_id" ]; then
          ibmcloud is key-delete $key_id -f
      fi
      ibmcloud config --check-version=false
      ibmcloud login -r ${self.triggers.region2} --apikey ${self.triggers.api_key}
      key_id=$(ibmcloud is keys | grep ${self.triggers.prefix}${self.triggers.bastion_ssh_key} | awk '{print $1}')
      if [ ! -z "$key_id" ]; then
          ibmcloud is key-delete $key_id -f
      fi  
    EOT    
  }
  depends_on = [
    ibm_is_floating_ip.bastion_floating_ip,
  ]
}

/**
* This null resource block is for deleting the dynamic ssh key generated via bastion server. This will execute on terraform destroy. 
* Element : delete_dynamic_ssh_key_windows
* This block is for those users who has Windows as their local machines.
**/

resource "null_resource" "delete_dynamic_ssh_key_windows" {
  count = lower(var.local_machine_os_type) == "windows" ? 1 : 0

  triggers = {
    region1         = var.region1
    region2         = var.region2
    api_key         = var.api_key
    prefix          = var.prefix
    bastion_ssh_key = local.bastion_ssh_key
    floating_ip     = ibm_is_floating_ip.bastion_floating_ip.address
  }
  provisioner "local-exec" {
    when        = destroy
    interpreter = ["PowerShell", "-Command"]
    command     = <<EOT
      Write-Host "Script starts"
      ibmcloud config --check-version=false
      ibmcloud login -r ${self.triggers.region1} --apikey ${self.triggers.api_key}
      $key_id = (ibmcloud is keys | findstr ${self.triggers.prefix}${self.triggers.bastion_ssh_key})
      ibmcloud is key-delete $key_id.split(" ")[0] -f
      ibmcloud config --check-version=false
      ibmcloud login -r ${self.triggers.region2} --apikey ${self.triggers.api_key}
      $key_id = (ibmcloud is keys | findstr ${self.triggers.prefix}${self.triggers.bastion_ssh_key})
      ibmcloud is key-delete $key_id.split(" ")[0] -f      
    EOT
  }
  depends_on = [
    ibm_is_floating_ip.bastion_floating_ip,
  ]
}