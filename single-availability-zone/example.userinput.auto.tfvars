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
# *   Enter your zone
# *   Please enter your nearest or desired zone to created your resources there. 
# *   Here are list of zones and related regions:

# *    "us-south-1" = "us-south"  #Dallas
# *    "us-south-2" = "us-south"
# *    "us-south-3" = "us-south"
# *    "us-east-1"  = "us-east"  #Washington DC
# *    "us-east-2"  = "us-east"
# *    "us-east-3"  = "us-east" 
# *    "eu-gb-1"    = "eu-gb"    #London
# *    "eu-gb-2"    = "eu-gb"
# *    "eu-gb-3"    = "eu-gb"    
# *    "eu-de-1"    = "eu-de"    #Frankfurt
# *    "eu-de-2"    = "eu-de"
# *    "eu-de-3"    = "eu-de"  
# *    "jp-tok-1"   = "jp-tok"    #Tokyo
# *    "jp-tok-2"   = "jp-tok"
# *    "jp-tok-3"   = "jp-tok" 
# *    "au-syd-1"   = "au-syd"    #Sydney
# *    "au-syd-2"   = "au-syd"
# *    "au-syd-3"   = "au-syd"  
# *    "jp-osa-1"   = "jp-osa"    #Osaka
# *    "jp-osa-2"   = "jp-osa"
# *    "jp-osa-3"   = "jp-osa"      
# *    "br-sao-1"   = "br-sao"    #Sao Paulo
# *    "br-sao-2"   = "br-sao"
# *    "br-sao-3"   = "br-sao"  
# *    "ca-tor-1"   = "ca-tor"    #Toronto
# *    "ca-tor-2"   = "ca-tor"
# *    "ca-tor-3"   = "ca-tor" 

# **/
# zone = "us-east-1"


# /**
# *   Enter your resource_group_id. 
# **/
# resource_group_id = "Enter your resource_group id"


# /** 
#     This is the list of the existing ssh key/keys name of user's system which will be used to login to the Bastion server. You can check your key name in IBM cloud.
#     Whose private key content should be there in path ~/.ssh/id_rsa 
#     If you don't have an existing key, then create one on your local system using <ssh-keygen -t rsa -b 4096 -C "user_ID"> command. And then create a ssh key in IBM cloud
#     with the public contents of file ~/.ssh/id_rsa.pub  
# */
# user_ssh_keys = "first-ssh-key,second-ssh-key"

# /**
# *   Operating System to be used [windows | mac | linux] for your local machine which is running terraform apply
# *   You can choose windows | linux | mac here.
# **/
# local_machine_os_type   = "mac"

# /** 
#     This is the list of public IP address of user's local machines. We will whitelist only these public IP in Bastion's security group. So that, Bastion server can 
#     be accessed only from the User's System.
#     Please update the public IP address list before every terraform apply. 
#     As your Public IP address could be dynamically changing each day. 
#     To get your Public IP you can use command <dig +short myip.opendns.com @resolver1.opendns.com> or visit "https://www.whatismyip.com"
#     The IP Address should be in format of X.X.X.X/32 and will be used to login to the bastion server
# */
#  public_ip_addresses = "123.201.8.30,219.91.139.49"


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
# bandwidth = 3


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
# *   Enter the strategy for DB servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
# *   You can choose host_spread | power_spread here.
# *   Here we have  db_pg_strategy = "power_spread"
# **/
# db_pg_strategy = "power_spread"

# /**
# *   Enter the strategy for Web servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
# *   You can choose host_spread | power_spread here.
# *   Here we have  web_pg_strategy = "host_spread"
# **/
# web_pg_strategy = "host_spread"

# /**
# *   Enter the strategy for App servers placement group - host_spread: place on different compute hosts - power_spread: place on compute hosts that use different power sources.
# *   You can choose host_spread | power_spread here.
# *   Here we have  app_pg_strategy = "host_spread"
# **/
# app_pg_strategy = "host_spread"

