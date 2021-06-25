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
  description = "This variable will display the private IP address of DB servers and the public IP address of Bastion Server"
  value = merge(
    {
      "PRIVATE_IP" = merge(
        { "DB" = module.instance.db_target }
      )
    },
    {
      "PUBLIC_IP" = merge(
        { "BASTION" = module.bastion.bastion_ip }
      )
    },
  )
}
