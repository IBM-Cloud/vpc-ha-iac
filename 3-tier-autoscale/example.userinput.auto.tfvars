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
# prefix = "ha-demo"


# /**
# *   Enter your region
# *   Please enter your nearest or desired region to created your resources there. 
# *   Here are list of regions and related zones:

#     "us-south"      = ["us-south-1", "us-south-2", "us-south-3"]
#     "us-east"       = ["us-east-1", "us-east-2", "us-east-3"]
#     "eu-gb"         = ["eu-gb-1", "eu-gb-2", "eu-gb-3"]
#     "eu-de"         = ["eu-de-1", "eu-de-2", "eu-de-3"]
#     "jp-tok"        = ["jp-tok-1", "jp-tok-2", "jp-tok-3"]
#     "au-syd"        = ["au-syd-1", "au-syd-2", "au-syd-3"] 

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
#     This is the public IP address of user's local machine. We will whitelist only this public IP in Bastion's security group. So that, Bastion server can 
#     be accessed only from the User's System.
#     Please update your public IP address before every terraform apply. 
#     As your Public IP address could be dynamically changing each day. 
#     To get your Public IP you can use command <dig +short myip.opendns.com @resolver1.opendns.com> or visit "https://www.whatismyip.com"
#     The IP Address should be in format of X.X.X.X and will be used to login to the bastion server
# */
# user_ip_address = "192.168.1.1"


# /**
# *   Enter bandwidth value. It is the value of Input/Output per second in GB. 
# *   Possible values are 3, 5 and 10. It will be used with data volume storage attached with the DB server.
# *   If you select 3, then the tiered profile used for the extra volume storage of DB server will be general-purpose
# *   If it is 5, then it would be 5iops-tier and if it is 10, then it would be 10iops-tier
# **/
# bandwidth = "3"


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
# *   Enter web_cpu_percent value. It is the threshold value for CPU policy. 
# *   Here we have:
# *   web_cpu_percent = "40"
# *   This means once the average CPU usage of all the VSI >=40 in Web Server then a new VSI will be added in the pool. 
# **/
# web_cpu_percent = "40"


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
# *   Enter app_cpu_percent value. It is the threshold value for CPU policy. 
# *   Here we have:
# *   app_cpu_percent = "40"
# *   This means once the average CPU usage of all the VSI >=40 in App Server then a new VSI will be added in the pool. 
# **/
# app_cpu_percent = "40"
