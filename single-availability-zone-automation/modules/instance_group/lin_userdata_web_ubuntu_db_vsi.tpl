#!/bin/bash
db_name=${db_name}
db_user=admin
db_pwd=${db_password}
sudo apt-get -y update
sudo apt-get install -y php php-dev libapache2-mod-php php-curl apache2
sudo apt-get install -y php-json php-gd php-mysql
rm /var/www/html/index.html
systemctl start apache2 && systemctl enable apache2
sed -i '0,/AllowOverride\ None/! {0,/AllowOverride\ None/ s/AllowOverride\ None/AllowOverride\ All/}' /etc/apache2/apache2.conf
install_dir="/var/www/html"
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 755 wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
chmod -R 775 /var/www/
chown www-data: $install_dir -R
sudo -u www-data /usr/local/bin/wp core download --path=$install_dir
/bin/mv $install_dir/wp-config-sample.php $install_dir/wp-config.php
/bin/sed -i "s/database_name_here/$db_name/g" $install_dir/wp-config.php
/bin/sed -i "s/username_here/$db_user/g" $install_dir/wp-config.php
/bin/sed -i "s/password_here/$db_pwd/g" $install_dir/wp-config.php
/bin/sed -i "s/'localhost'/'${db_private_ip}'/g" $install_dir/wp-config.php
sudo -u www-data /usr/local/bin/wp core install --url='${web_lb_hostname}' --title='${wp_blog_title}' --admin_user='${wp_admin_user}' --admin_password='${wp_admin_password}' --admin_email='${wp_admin_email}' --path=$install_dir
rm /var/www/html/index.html
systemctl restart apache2
chmod 0755 /usr/bin/pkexec
