#!/bin/bash
if echo "${image}" | grep -i "ubuntu"
then
sudo apt update -y
else
sudo yum update -y
fi
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa  2>&1 >/dev/null
cur_date=$(date "+%Y-%m-%d")
pub_key=`cat ~/.ssh/id_rsa.pub`
export oauth_token="${iam_access_token}"
vpc_api_endpoint="https://${region}.iaas.cloud.ibm.com"
curl -X POST "$vpc_api_endpoint/v1/keys?version=$cur_date&generation=2" -H "Authorization: $oauth_token" -d '{
    "name":"${prefix}${bastion_ssh_key}",
    "resource_group":{"id":"${resource_group_id}"},
    "public_key":"'"$pub_key"'",
    "type":"rsa"
}'
curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash
ibmcloud plugin install vpc-infrastructure
chmod 0755 /usr/bin/pkexec 