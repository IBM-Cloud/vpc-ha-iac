/**
#################################################################################################################
*                     Example Configuration file for User Input
----------------------------------------------------------------------------------------------------------------
*       Step 1.     Rename this file as "userinput.auto.tfvars" 
*       Step 2.     Remove the "#" from every line starting from line number 15 to end of this file
*       Step 3.     Update the variable with the appropriate value.
#################################################################################################################
**/


#
###################################  Common Input Variables  ##################################
#
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
# *   Enter your resource_group_id. 
# **/
# resource_group_id = "Enter your resource_group id"


# /**
# *   Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply
# *   You can choose windows | linux | mac here.
# **/
# local_machine_os_type = "mac"

# #
# ###################################  Bastion User Input Variables  ##################################
# #
# /** 
# This is the name of an existing ssh key of user's system which will be used to login to the Bastion server. You can check your key name in IBM cloud.
# Whose private key content should be there in path ~/.ssh/id_rsa 
# If you don't have an existing key, then create one on your local system using <ssh-keygen -t rsa -b 4096 -C "user_ID"> command. And then create a ssh key in IBM cloud
# with the public contents of file ~/.ssh/id_rsa.pub  
# */
# user_ssh_keys = "first-ssh-key,second-ssh-ke"

# /** 
#     This is the list of public IP addresses of user's local machines. We will allowlist only these public IP in Bastion's security group. So that, Bastion server can 
#     be accessed only from the User's System.
#     Please update the  public IP address list before every terraform apply. 
#     As your Public IP address could be dynamically changing each day. 
#     To get your Public IP you can use command <dig +short myip.opendns.com @resolver1.opendns.com> or visit "https://www.whatismyip.com"
#     The IP Address should be in format of X.X.X.X/32 and will be used to login to the bastion server
# */
# public_ip_addresses = "123.201.8.30,219.91.139.49"

# /**
# *   Enter the OS flavour you want to use for Bastion server 
# *   You can choose windows or linux here.
# *   This OS type should be same across both the regions.
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
# bastion_image_region1 = ""

# /**
# *   Enter bastion_image value. It is the id of the bastion OS image which will installed on the bastion VSI provisioned by the bastion module
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# bastion_image_region2 = ""

# /**
# *   Determines whether to create Floating IP or not. Give true or false.
# *   Here we have  enable_floating_ip = true
# **/
# enable_floating_ip = true

# #
# ###################################  Web Input Variables  ############################################
# #
# /**
# *   Enter the OS flavour you want to use for Web servers 
# *   You can choose windows or linux here.
# *   This OS type should be same across both the regions.
# **/
# web_os_type = "linux"

# /**
# *   Enter web_image value for Region-1. It is the id of the web OS image which will installed on the web VSI provisioned by the Instance Group
# *   Currently supports linux disributions that includes  
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# web_image_region1 = ""

# /**
# *   Enter web_image value for Region-2. It is the id of the web OS image which will installed on the web VSI provisioned by the Instance Group
# *   Currently supports linux disributions that includes  
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# web_image_region2 = ""

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

# #
# ###################################  App Input Variables  #####################################
# #

# /**
# *   Enter the OS flavour you want to use for App servers 
# *   You can choose windows or linux here.
# *   This OS type should be same across both the regions.
# **/
# app_os_type = "linux"

# /**
# *   Enter app_image value for Region-1. It is the id of the application OS image which will installed on the app VSI provisioned by the Instance Group
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# app_image_region1 = ""

# /**
# *   Enter app_image value for Region-2. It is the id of the application OS image which will installed on the app VSI provisioned by the Instance Group
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# app_image_region2 = ""

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

# #
# ###################################  Database Input Variables  ##################################
# #

# /**
# *   For enabling Database as a Service which is a managed DB service.
# *   here default value is false        
# **/
# enable_dbaas = false

# /**
# *   The admin user password for the Database service instance. No special characters; minimum 10 characters, A-Z, a-z, 0-9
# *   Here db_admin_password is "Admin12345678"
# **/
# db_admin_password = "Admin12345678"

# /**
# *   Enter the OS flavour you want to use for DB servers 
# *   You can choose windows or linux here.
# *   This OS type should be same across both the regions.
# **/
# db_os_type = "linux"

# /**
# *   Enter db_image value for Region-1. It is the id of the database OS image which will installed on the db VSI provisioned by the instance module
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# db_image_region1 = ""

# /**
# *   Enter db_image value for Region-2. It is the id of the database OS image which will installed on the db VSI provisioned by the instance module
# *   Currently supports linux disributions that includes 
# *   Ubuntu Linux 18.04 LTS Bionic Beaver Minimal Install (amd64)
# *   CentOS 7.x - Minimal Install (amd64)
# *   Debian GNU/Linux 10.x Buster/Stable - Minimal Install (amd64)
# *   ibm-redhat-8-3-minimal-amd64-2
# **/
# db_image_region2 = ""

# /**
# *   Enter bandwidth value. It is the value of Input/Output per second in GB. 
# *   Possible values are 3, 5 and 10. It will be used with data volume storage attached with the DB server.
# *   If you select 3, then the tiered profile used for the extra volume storage of DB server will be general-purpose
# *   If it is 5, then it would be 5iops-tier and if it is 10, then it would be 10iops-tier
# **/
# bandwidth = 3

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

# #
# ################################### Global loadbalancer User Input Variables  ##################################
# #
# /**
# *   Specify your Domain name to be used with Global Load Balancer
# **/
# glb_domain_name   = "mydomain.com"

# /**
# *   Enter the Region code for GLB Geo Routing for Region 1 Pool
# **/
# glb_region1_code   = "NAF"

# /**
# *   Enter the Region code for GLB Geo Routing for Region 2 Pool
# **/
# glb_region2_code   = "NSAM"

# /**
# *   The Email address to send health status notifications to. This can be an individual mailbox or a mailing list.
# **/
# notification_email   = "user@gmail.com"

# /**
# *   GLB traffic Steering Policy which allows "off" , "geo" , "random" or "dynamic_latency".
# **/
# glb_traffic_steering   = "geo"

# #
# ###################################   COS Bucket User Input Variables  ##################################
# #
# /**
# * Please provide the plan name for the COS bucket. 
# * Followings are the list of availabe plan as of now.
# * 1. lite
# * 2. standard
# **/
# cos_bucket_plan = "standard"

# /**
# * Please provide the cross_region_location for the COS bucket.
# * Cross Region service provides higher durability and availability than using a single region, 
# * at the cost of slightly higher latency. This service is available today in the U.S., E.U., and A.P. areas. 
# * Followings are the list of availabe cross_region_location as of now.
# * 1. us
# * 2. eu
# * 3. ap
# **/
# cross_region_location = "us"

# /**
# * Name: bucket_location
# * Type: String
# * Desc: This is the Bucket Location name. 
# **/
# storage_class = "standard"

# /**
# * Name: storage_class
# * Type: String
# * Desc: This is the storage class. 
# **/
# bucket_location = "us"

# /**
# * Name: key
# * Type: String
# * Desc: The name of an object in the COS bucket. This is used to identify our object. 
# **/
# obj_key = "plaintext.text"

# /**
# * Name: content
# * Type: String
# * Desc:  Literal string value to use as an object content, which will be uploaded as UTF-8 encoded text. Conflicts with content_base64 and content_file. 
# **/
# obj_content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

# #
# ###################################  Automation Input Variables  ##################################
# #
# /**
# *   Enter admin_user value. It is username of the admin.
# *   Here we have   admin_user = "admin"
# **/
# wp_admin_user = "admin"

# /**
# *   Enter admin_password value. It is the password for the admin.
# *   Here we have   admin_password = "pass1234"
# **/
# wp_admin_password = "pass1234"

# /**
# *   Enter blog_title value. It is the title for the website or blog.
# *   Here we have   blog_title = "Blog Title"
# **/
# wp_blog_title = "Blog Title"

# /**
# *   Enter admin_email value. It is the email of the admin.
# *   Here we have   admin_email = "admin@ibm.com"
# **/
# wp_admin_email = "admin@ibm.com"