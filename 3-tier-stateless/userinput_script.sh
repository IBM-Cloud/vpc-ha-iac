touch userinput.auto.tfvars

echo "\nEnter your IBM cloud API key here:"
read -r api_key
echo "api_key = \"$api_key\"" > userinput.auto.tfvars

echo "\nEnter prefix string ending with hyphen (-). This is the prefix text that will be prepended in every resource name created by this script. [For example: ha-demo-]:"
read -r prefix
echo "prefix = \"$prefix\"" >> userinput.auto.tfvars

echo "\nPlease enter your nearest or desired region to created your resources there. [For example: us-east]:"
read -r region
echo "region = \"$region\"" >> userinput.auto.tfvars

echo "\nEnter your resource_group_id:"
read -r resource_group_id
echo "resource_group_id = \"$resource_group_id\"" >> userinput.auto.tfvars

echo "\nEnter the list of existing ssh key of user's systems which will be used to login to the Bastion server. You can check your key name in IBM cloud:"
read -r user_ssh_key
echo "user_ssh_key = $user_ssh_key" >> userinput.auto.tfvars

echo "\nEnter the list of public IP addresses of user's local machines. We will whitelist only these public IPs in Bastion's security group. Please update the public IP address list before every terraform apply:"
read -r public_ip_address_list
echo "public_ip_address_list = $public_ip_address_list" >> userinput.auto.tfvars

echo "\nEnter bastion image id. It is the id of the bastion OS image which will installed on the bastion VSI provisioned by the bastion module. Currently supports linux disributions:"
read -r bastion_image
echo "bastion_image = \"$bastion_image\"" >> userinput.auto.tfvars

echo "\nEnter db image id. It is the id of the database OS image which will installed on the database VSI provisioned by the Instance module. Currently supports linux disributions:"
read -r db_image
echo "db_image = \"$db_image\"" >> userinput.auto.tfvars

echo "\nEnter web image id. It is the id of the Web OS image which will installed on the Web VSI provisioned by the Instance group module. Currently supports linux disributions:"
read -r web_image
echo "web_image = \"$web_image\"" >> userinput.auto.tfvars

echo "\nEnter app image id. It is the id of the App OS image which will installed on the App VSI provisioned by the Instance group module. Currently supports linux disributions:"
read -r app_image
echo "app_image = \"$app_image\"" >> userinput.auto.tfvars

echo "\nEnter the OS flavour you want to use for Bastion server. You can enter windows or linux here:"
read -r bastion_os_type
echo "bastion_os_type = \"$bastion_os_type\"" >> userinput.auto.tfvars

echo "\nEnter the OS flavour you want to use for App server. You can enter windows or linux here:"
read -r app_os_type
echo "app_os_type = \"$app_os_type\"" >> userinput.auto.tfvars

echo "\nEnter the OS flavour you want to use for Web server. You can enter windows or linux here:"
read -r web_os_type
echo "web_os_type = \"$web_os_type\"" >> userinput.auto.tfvars

echo "\nEnter the OS flavour you want to use for DB server. You can enter windows or linux here:"
read -r db_os_type
echo "db_os_type = \"$db_os_type\"" >> userinput.auto.tfvars

echo "\nOperating System to be used [windows | mac | linux] for your local machine which is running terraform apply. You can enter windows | linux | mac here:"
read -r local_machine_os_type
echo "local_machine_os_type = \"$local_machine_os_type\"" >> userinput.auto.tfvars