/**
#################################################################################################################
*                                   Output Variable Section
#################################################################################################################
**/

/**
* Output Variable
* Element : Load Balancer Region 2
* Load Balancer IP and DNS for App, DB and Web Tier
* This variable will output the IP address and DNS for App, DB and Web for region1
**/
output "LOAD_BALANCER_REGION_1" {
  description = "This variable will display the private and public IP addresses and DNS of load balancers for region1"
  value = merge(
    { "PRIVATE_IP" = module.load_balancer_region1.lb_private_ip },
    { "PUBLIC_IP" = module.load_balancer_region1.lb_public_ip },
    { "DNS" = module.load_balancer_region1.lb_dns }
  )
}

/**
* Output Variable
* Element : Load Balancer Region 2
* Load Balancer IP and DNS for App, DB and Web Tier
* This variable will output the IP address and DNS for App, DB and Web for region2
**/
output "LOAD_BALANCER_REGION_2" {
  description = "This variable will display the private and public IP addresses and DNS of load balancers for region2"
  value = merge(
    { "PRIVATE_IP" = module.load_balancer_region2.lb_private_ip },
    { "PUBLIC_IP" = module.load_balancer_region2.lb_public_ip },
    { "DNS" = module.load_balancer_region2.lb_dns }
  )
}


/**
* Output Variable
* Element : Virtual Server Instance
* This variable will output the Private IP address of Web and App IG servers
**/
output "IG_WEB_APP_VSI" {
  description = "This variable will display the private IP address of Web and App IG servers"
  value = merge(
    {
      "PRIVATE_IP" = merge(
        { "WEB_REGION1" = module.instance_group_region1.web_instances_ip },
        { "WEB_REGION2" = module.instance_group_region2.web_instances_ip },
        { "APP_REGION1" = module.instance_group_region1.app_instances_ip },
        { "APP_REGION2" = module.instance_group_region2.app_instances_ip }
      )
    },
  )
}


/**
* Output Variable
* Element : DB_Host
* This variable will output the host or IP address of the database server.
**/
output "DB_Host_region1" {
  description = "This variable will output the host or IP address of the database server"
  value       = var.enable_dbaas ? module.db_region1[0].db_hostname : module.instance_region1[0].db_target[0]
}
output "DB_Host_region2" {
  description = "This variable will output the host or IP address of the database server"
  value       = var.enable_dbaas ? module.db_region2[0].db_hostname : module.instance_region2[0].db_target[0]
}


/**
* Output Variable
* Element : db_connection_command_region_1
* This ouput variable will output the Database connection command which is useful for the server to connect to the database.
**/
output "db_connection_command_region_1" {
  description = "This ouput variable will output the Database connection command which is useful for the server to connect to the database."
  #value       = module.db_region1.db_connection_command
  value       = var.enable_dbaas ? module.db_region1[0].db_connection_command : "mysql -h ${module.instance_region1[0].db_target[0]} -u admin -p"

}

/**
* Output Variable
* Element : db_connection_command_region_2
* This ouput variable will output the Database connection command which is useful for the server to connect to the database.
**/
output "db_connection_command_region_2" {
  description = "This ouput variable will output the Database connection command which is useful for the server to connect to the database."
  value       = var.enable_dbaas ? module.db_region2[0].db_connection_command : "mysql -h ${module.instance_region2[0].db_target[0]} -u admin -p"
}

/**
* Output Variable
* Element : Bastion VSI
* This variable will output the Public IP address for bastion server.
**/
output "BASTION_VSI" {
  description = "This variable will display the public IP address of Bastion Server"
  value = var.enable_floating_ip ? merge(
    {
      "PUBLIC_IP" = merge(
        { "BASTION1" = module.bastion_region1.bastion_ip },
        { "BASTION2" = module.bastion_region2.bastion_ip }
      )
    }
  ) : null
}

/**
* Output Variable
* Element : COS Public and Private endpoint
* This variable will return the public and private end points for the COS bucket.
**/
output "COS_BUCKET" {
  value = module.cos.object_endpoint
}
