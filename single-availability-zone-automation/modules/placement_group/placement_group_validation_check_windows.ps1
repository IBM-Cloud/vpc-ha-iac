$web_pg_strategy=$args[0]
$web_max_servers_count=$args[1]
if ( $web_pg_strategy -eq "power_spread" ){
        if ( $web_max_servers_count -gt 4 ){
                echo "`n Web Validation Failed! Power spread placement group strategy supports a maximum of 4 instances per placement group and provided web instance group max server count is $web_max_servers_count"
                exit 1
        }
}
elseif ( $web_pg_strategy -eq "host_spread" ){
        if ( $web_max_servers_count -gt 12 ){
                echo "`n Web Validation Failed! Host spread placement policy supports a maximum of 12 instances per placement group and provided web instance group max server count is $web_max_servers_count"
                exit 1
        }
}
     
echo "`n `n Web Validation Passed! Max web server count is $web_max_servers_count for Web placement group strategy $web_pg_strategy which is under max limit." 

$app_pg_strategy=$args[2]
$app_max_servers_count=$args[3]
if ( $app_pg_strategy -eq "power_spread" ){
        if ( $app_max_servers_count -gt 4 ){
                echo "`n App Validation Failed! Power spread placement group strategy supports a maximum of 4 instances per placement group and provided app instance group max server count is $app_max_servers_count"
                exit 1
        }
}
elseif ( $app_pg_strategy -eq "host_spread" ){
        if ( $app_max_servers_count -gt 12 ){
                echo "`n App Validation Failed! Host spread placement policy supports a maximum of 12 instances per placement group and provided app instance group max server count is $app_max_servers_count"
                exit 1
        }
}
     
echo "`n `n App Validation Passed! Max app server count is $app_max_servers_count for App placement group strategy $app_pg_strategy which is under max limit." 

$db_pg_strategy=$args[4]
$db_vsi_count=$args[5]
if ( $db_pg_strategy -eq "power_spread" ){
        if ( $db_vsi_count -gt 4 ){
                echo "`n Database Validation Failed! Power spread placement group strategy supports a maximum of 4 instances per placement group and provided Database VSI count is $db_vsi_count"
                exit 1
        }
}
elseif ( $db_pg_strategy -eq "host_spread" ){
        if ( $db_vsi_count -gt 12 ){
                echo "`n Database Validation Failed! Host spread placement policy supports a maximum of 12 instances per placement group and provided Database VSI count is $db_vsi_count"
                exit 1
        }
}
     
echo "`n `n Database Validation Passed! Database VSI count is $db_vsi_count for Database placement group strategy $db_pg_strategy which is under max limit. `n" 