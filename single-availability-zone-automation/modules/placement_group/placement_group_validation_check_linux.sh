web_pg_strategy=$1
web_max_servers_count=$2
if [ $web_pg_strategy = "power_spread" ]; then
        if [ $web_max_servers_count -gt 4 ]; then
                echo "\n Web Validation Failed! Power spread placement group strategy supports a maximum of 4 instances per placement group and provided web instance group max server count is $web_max_servers_count"
                exit 1
        fi
elif [ $web_pg_strategy = "host_spread" ]; then
        if [ $web_max_servers_count -gt 12 ]; then
                echo "\n Web Validation Failed! Host spread placement policy supports a maximum of 12 instances per placement group and provided web instance group max server count is $web_max_servers_count"
                exit 1
        fi
fi       
echo "\n \n Web Validation Passed! Max web server count is $web_max_servers_count for Web placement group strategy $web_pg_strategy which is under max limit."

app_pg_strategy=$3
app_max_servers_count=$4
if [ $app_pg_strategy = "power_spread" ]; then
        if [ $app_max_servers_count -gt 4 ]; then
                echo "\n \n App Validation Failed! Power spread placement group strategy supports a maximum of 4 instances per placement group and provided app instance group max server count is $app_max_servers_count"
                exit 1
        fi
elif [ $app_pg_strategy = "host_spread" ]; then
        if [ $app_max_servers_count -gt 12 ]; then
                echo "\n \n App Validation Failed! Host spread placement policy supports a maximum of 12 instances per placement group and provided app instance group max server count is $app_max_servers_count"
                exit 1
        fi
fi 
echo "\n App Validation Passed! Max app server count is $app_max_servers_count for App placement group strategy $app_pg_strategy which is under max limit."

db_pg_strategy=$5
db_vsi_count=$6
if [ $db_pg_strategy = "power_spread" ]; then
        if [ $db_vsi_count -gt 4 ]; then
                echo "\n \n Database Validation Failed! Power spread placement group strategy supports a maximum of 4 instances per placement group and provided Database VSI count is $db_vsi_count"
                exit 1
        fi
elif [ $db_pg_strategy = "host_spread" ]; then
        if [ $db_vsi_count -gt 12 ]; then
                echo "\n \n Database Validation Failed! Host spread placement policy supports a maximum of 12 instances per placement group and provided Database VSI count is $db_vsi_count"
                exit 1
        fi
fi 
echo "\n Database Validation Passed! Database VSI count is $db_vsi_count for Database placement group strategy $db_pg_strategy which is under max limit. \n"