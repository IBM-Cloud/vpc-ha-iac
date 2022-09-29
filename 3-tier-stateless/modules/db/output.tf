/**
#################################################################################################################
*                                 Output Variable Section for the db Module.
#################################################################################################################
**/


output "db_connection_command" {
  value = "MYSQL_PWD=<Admin-PASSWORD> mysql --host=${ibm_database.db.connectionstrings[0].hosts[0].hostname} --port=${ibm_database.db.connectionstrings[0].hosts[0].port} --user=admin ibmclouddb"
}

output "db_certificate" {
  value = "${ibm_database.db.connectionstrings[0].certbase64}}"
}

output "db_hostname" {
  value = ibm_database.db.connectionstrings[0].hosts[0].hostname
}

output "db_port" {
  value = ibm_database.db.connectionstrings[0].hosts[0].port
}
