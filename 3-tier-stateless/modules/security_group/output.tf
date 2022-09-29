/**
#################################################################################################################
*                                 Security Groups Output Variable Section
#################################################################################################################
**/


/**
* Output Variable for Web Server Security Group
* This variable will return the Web Security Group ID 
**/
output "web_sg" {
  value       = ibm_is_security_group.web.id
  description = "Security Group id for the web"
}


/**
*
* Output Variable for Load Balancer Security Group
* This variable will return the Load Balancer Security Group ID 
* 
**/
output "lb_sg" {
  value       = ibm_is_security_group.lb_sg.id
  description = "Security Group ID for Load Balancer"
}

/**
*
* Output Variable for App Server Security Group
* This variable will return the App Security Group ID 
* 
**/
output "app_sg" {
  value       = ibm_is_security_group.app.id
  description = "Security Group id for the app"
}

/**
*
* Output Variable for DB Server Security Group
* This variable will return the DB Security Group ID 
* 
**/
output "db_sg" {
  value       = ibm_is_security_group.db.id
  description = "Security Group id for the db"
}

/**
* Output Variable: sg_objects
* Element : sg_objects objects
* This variable will return the objects for the following subnets
* Objects: 
* app
* db
* lb
* web
**/
output "sg_objects" {
  description = "This output variable will expose the objects of all security groups"
  value = {
    "app" = ibm_is_security_group.app,
    "lb"  = ibm_is_security_group.lb_sg,
    "web" = ibm_is_security_group.web
  }
}

/**
#################################################################################################################
*                                 Security Groups Output Variable Section
#################################################################################################################
**/