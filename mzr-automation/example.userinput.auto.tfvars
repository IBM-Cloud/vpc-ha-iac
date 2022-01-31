/**
#################################################################################################################
*                     Example Configuration file for User Input
----------------------------------------------------------------------------------------------------------------
*       Step 1.     Rename this file as "userinput.auto.tfvars" 
*       Step 2.     Remove the "#" from every line starting from line number 15 to end of this file
*       Step 3.     Update the variable with the appropriate value.
#################################################################################################################
**/


# /**
# *   Enter your IBM cloud API key here.
# **/
# api_key = "Enter your IBM Cloud Api Key"


# /**
# *   Enter prefix string ending with dash (-).
# *   This is the prefix text that will be prepended in every resource name created by this script.
# *   For example "ha-demo-"
# **/
# prefix = "ha-demo-"


# /**
# *   Enter your region
# *   Please enter your nearest or desired region to created your resources there. 
# *   Here are list of regions and related zones:

# *   "us-south"      = ["us-south-1", "us-south-2", "us-south-3"]  #Dallas
# *   "us-east"       = ["us-east-1", "us-east-2", "us-east-3"]     #Washington DC
# *   "eu-gb"         = ["eu-gb-1", "eu-gb-2", "eu-gb-3"]           #London
# *   "eu-de"         = ["eu-de-1", "eu-de-2", "eu-de-3"]           #Frankfurt
# *   "jp-tok"        = ["jp-tok-1", "jp-tok-2", "jp-tok-3"]        #Tokyo
# *   "au-syd"        = ["au-syd-1", "au-syd-2", "au-syd-3"]        #Sydney
# *   "jp-osa"        = ["jp-osa-1", "jp-osa-2", "jp-osa-3",]       #Osaka
# *   "ca-tor"        = ["ca-tor-1", "ca-tor-2", "ca-tor-3"]        #Toronto
# *   "br-sao"        = ["br-sao-1", "br-sao-2", "br-sao-3"]        #Sao Paulo

# **/
# region = "us-east"


# /**
# *   Enter your resource_group_id. 
# **/
# resource_group_id = "Enter your resource_group id"


# /** 
#     This is the name of an existing ssh key of user's system which will be used to login to the Bastion server. You can check your key name in IBM cloud.
#     Whose private key content should be there in path ~/.ssh/id_rsa 
#     If you don't have an existing key, then create one on your local system using <ssh-keygen -t rsa -b 4096 -C "user_ID"> command. And then create a ssh key in IBM cloud
#     with the public contents of file ~/.ssh/id_rsa.pub  
# */
# user_ssh_key = "Enter your IBM cloud ssh key name"

# /**
# *   Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply
# *   You can choose windows | linux | mac here.
# **/
# local_machine_os_type   = "mac"

# /** 
#     This is the public IP address of user's local machine. We will whitelist only this public IP in Bastion's security group. So that, Bastion server can 
#     be accessed only from the User's System.
#     Please update your public IP address before every terraform apply. 
#     As your Public IP address could be dynamically changing each day. 
#     To get your Public IP you can use command <dig +short myip.opendns.com @resolver1.opendns.com> or visit "https://www.whatismyip.com"
#     The IP Address should be in format of X.X.X.X and will be used to login to the bastion server
# */
# my_public_ip = "192.168.1.1"


# /**
# *   Enter the OS flavour you want to use for Bastion server 
# *   You can choose windows or linux here.
# **/
# bastion_os_type = "linux"

# /**
# *   Enter bastion_image value. It is the id of the bastion OS image which will installed on the bastion VSI provisioned by the bastion module
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# bastion_image = ""

# /**
# *   Enter the OS flavour you want to use for DB servers 
# *   You can choose windows or linux here.
# **/
# db_os_type = "linux"

# /**
# *   Enter db_image value. It is the id of the database OS image which will installed on the db VSI provisioned by the instance module
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# db_image = ""

# /**
# *   Enter bandwidth value. It is the value of Input/Output per second in GB. 
# *   Possible values are 3, 5 and 10. It will be used with data volume storage attached with the DB server.
# *   If you select 3, then the tiered profile used for the extra volume storage of DB server will be general-purpose
# *   If it is 5, then it would be 5iops-tier and if it is 10, then it would be 10iops-tier
# **/
# bandwidth = "3"


# /**
# *   Enter the OS flavour you want to use for Web servers 
# *   You can choose windows or linux here.
# **/
# web_os_type = "linux"

# /**
# *   Enter web_image value. It is the id of the web OS image which will installed on the web VSI provisioned by the Instance Group
# *   Currently supports linux disributions that includes  
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# web_image = ""

# /**
# *   Enter web_min_servers_count value. It is the minimum number of VSI that will be provisioned by the Instance Group.
# *   Regardless the policies threshold. Here we have 2 there must be two VSI created. 
# **/
# web_min_servers_count = "2"

# /**
# *   Enter web_max_servers_count value. It is the maximum number of VSI that will be provisioned by the Instance Group.
# *   It includes the minimum limit as well. 
# *   Here we have: 
# *   web_min_servers_count = 2
# *   web_max_servers_count = 5
# *   So we may have maximum of only 5 VSI once the policies threshold matches. 
# **/
# web_max_servers_count = "5"

# /**
# *   Enter web_cpu_threshold value. It is the threshold value for CPU policy. 
# *   Here we have:
# *   web_cpu_threshold = "40"
# *   This means once the average CPU usage of all the VSI >=40 in Web Server then a new VSI will be added in the pool. 
# **/
# web_cpu_threshold = "40"


# /**
# *   Enter the OS flavour you want to use for App servers 
# *   You can choose windows or linux here.
# **/
# app_os_type = "linux"

# /**
# *   Enter app_image value. It is the id of the application OS image which will installed on the app VSI provisioned by the Instance Group
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# app_image = ""

# /**
# *   Enter app_min_servers_count value. It is the minimum number of VSI that will be provisioned by the Instance Group.
# *   Regardless the policies threshold. Here we have 2 there must be two VSI created. 
# **/
# app_min_servers_count = "2"

# /**
# *   Enter app_max_servers_count value. It is the maximum number of VSI that will be provisioned by the Instance Group.
# *   It includes the minimum limit as well. 
# *   Here we have: 
# *   app_min_servers_count = 2
# *   app_max_servers_count = 5
# *   So we may have maximum of only 5 VSI once the policies threshold matches. 
# **/
# app_max_servers_count = "5"

# /**
# *   Enter app_cpu_threshold value. It is the threshold value for CPU policy. 
# *   Here we have:
# *   app_cpu_threshold = "40"
# *   This means once the average CPU usage of all the VSI >=40 in App Server then a new VSI will be added in the pool. 
# **/
# app_cpu_threshold = "40"

# /** 
#     Mode used in VPN gateway. Supported values are route or policy.
#     User should make the configuration updations on their onprem side VPN accordingly on the basis of IBM side VPN.
# **/
# vpn_mode  = "policy"

# /**
# *   List of peer CIDRs for the creation of VPN connection.
# *   IBM VPC CIDR and User’s on-prem subnet CIDR should NOT overlap if VPN is being used.
# **/
# peer_cidrs  = ["x.x.x.x/x"]

# /**
# *   The IP address of the peer VPN gateway.
# **/
# peer_gateway_ip = "x.x.x.x"

# /**
# *   The Key configured on the peer gateway. The key is usually a complex string similar to a password.
# **/
# preshared_key   = "VPNDemoPassword"

# /**
# *   Enter db_name value. It is the Database name.
# *   Here we have  db_name = "wpdb"
# **/
# db_name = "wpdb"

# /**
# *   Enter db_user value. It is the Database Username.
# *   Here we have   db_user = "wpuser"
# **/
# db_user = "wpuser"

# /**
# *   Enter db_pwd value. It is the Database Password.
# *   Here we have   db_pwd = "start123"
# **/
# db_pwd = "start123"

# /**
# *   Enter admin_user value. It is username of the admin.
# *   Here we have   wp_admin_user = "admin"
# **/
#wp_admin_user = "admin"

# /**
# *   Enter admin_password value. It is the password for the admin.
# *   Here we have   wp_admin_password = "pass1234"
# **/
#wp_admin_password = "pass1234"

# /**
# *   Enter blog_title value. It is the title for the website or blog.
# *   Here we have   wp_blog_title = "Blog Title"
# **/
#wp_blog_title = "Blog Title"

# /**
# *   Enter admin_email value. It is the email of the admin.
# *   Here we have   wp_admin_email = "admin@ibm.com"
# **/
#wp_admin_email = "admin@ibm.com"
