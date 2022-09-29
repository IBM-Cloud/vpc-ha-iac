/**
#################################################################################################################
*                                         Output Variable Section
#################################################################################################################
**/

/**
* Output Variable
* Element : Load Balancer
* Load Balancer IP and DNS for App, DB and Web Tier
* This variable will output the IP address and DNS for App, DB and Web
**/
output "LOAD_BALANCER" {
  description = "This variable will display the private and public IP addresses and DNS of load balancers"
  value = merge(
    { "PRIVATE_IP" = module.load_balancer.lb_private_ip },
    { "PUBLIC_IP" = module.load_balancer.lb_public_ip },
    { "DNS" = module.load_balancer.lb_dns }
  )
}

/**
* Output Variable
* Element : Virtual Server Instance
* Virtual Server Instance Private IP Addresses for App, DB and Web
* This variable will output the IP addresses and DNS for App, DB and Web
**/
output "VSI" {
  description = "This variable will display the private IP addresses of App/Web/DB servers"
  value = merge(
    {
      "PRIVATE_IP" = merge(
        { "App" = module.instance.app_target },
        { "Web" = module.instance.web_target },
      )
    },
  )
}

/**
* Output Variable
* Element : Virtual Server Instance
* This variable will output the Public IP address of Bastion server
**/
output "BASTION_PUBLIC_IP" {
  description = "This variable will display the public IP address of Bastion Server"
  value       = var.enable_floating_ip ? module.bastion.bastion_ip : null
}

/**
* Output Variable
* Element : DB_Host
* This variable will output the host or IP address of the database server.
**/
output "DB_Host" {
  description = "This variable will output the host or IP address of the database server"
  value       = var.enable_dbaas ? module.db[0].db_hostname : module.instance.db_target[0]
}

# /**
# * Output Variable
# * Element : db_connection_command
# * This ouput variable will output the Database connection command which is useful for the server to connect to the database.
# **/
output "db_connection_command" {
  description = "This ouput variable will output the Database connection command which is useful for the server to connect to the database."
  value       = var.enable_dbaas ? module.db[0].db_connection_command : "mysql -h ${module.instance.db_target[0]} -u admin -p"
}