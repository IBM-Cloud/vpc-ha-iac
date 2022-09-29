#!/bin/bash
if cat /etc/redhat-release |grep -i "release 7"
then
sudo yum update -y 
sudo yum install -y httpd git wget
systemctl start httpd && systemctl enable httpd
db_name=${db_name}
db_user=admin
db_pwd=${db_password}
install_dir="/var/www/html"
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
sudo yum-config-manager --enable remi-php72
sudo yum update -y
sudo yum install -y php php-pear php-json php-gd php-mysql
chown -R apache $install_dir -R
chmod -R 775 /var/www/
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 755 wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
/usr/local/bin/wp --info
sudo -u apache /usr/local/bin/wp core download --path=$install_dir
/bin/mv $install_dir/wp-config-sample.php $install_dir/wp-config.php
/bin/sed -i "s/database_name_here/$db_name/g" $install_dir/wp-config.php
/bin/sed -i "s/username_here/$db_user/g" $install_dir/wp-config.php
/bin/sed -i "s/password_here/$db_pwd/g" $install_dir/wp-config.php
/bin/sed -i "s/'localhost'/'${db_private_ip}'/g" $install_dir/wp-config.php
sudo -u apache /usr/local/bin/wp core install --url='${web_lb_hostname}' --title='${wp_blog_title}' --admin_user='${wp_admin_user}' --admin_password='${wp_admin_password}' --admin_email='${wp_admin_email}' --path=$install_dir
setenforce Permissive
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --reload
setenforce Enforcing
sudo setsebool -P httpd_can_network_connect 1
systemctl restart httpd  
else
yum update -y 
yum install -y httpd php git wget
yum install -y php-pear php-json php-gd php-mysqlnd
systemctl start httpd && systemctl enable httpd
db_user=admin
db_pwd=${db_password}
install_dir="/var/www/html"
chown -R apache $install_dir -R
chmod -R 775 /var/www/
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 755 wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
/usr/local/bin/wp --info
sudo -u apache /usr/local/bin/wp core download --path=$install_dir
/bin/mv $install_dir/wp-config-sample.php $install_dir/wp-config.php
/bin/sed -i "s/database_name_here/$db_name/g" $install_dir/wp-config.php
/bin/sed -i "s/username_here/$db_user/g" $install_dir/wp-config.php
/bin/sed -i "s/password_here/$db_pwd/g" $install_dir/wp-config.php
/bin/sed -i "s/'localhost'/'${db_private_ip}'/g" $install_dir/wp-config.php
sudo -u apache /usr/local/bin/wp core install --url='${web_lb_hostname}' --title='${wp_blog_title}' --admin_user='${wp_admin_user}' --admin_password='${wp_admin_password}' --admin_email='${wp_admin_email}' --path=$install_dir
systemctl restart httpd
fi
chmod 0755 /usr/bin/pkexec