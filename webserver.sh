#!/bin/bash
# Install httpd & nginx
yum -y install epel-release yum-utils;
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm;
yum-config-manager --enable remi-php72;
yum -y update;
yum install -y nginx;
yum -y install httpd php-mcrypt php-cli php-gd php-curl php-ldap php-zip php-fileinfo php php72 php-fpm php-mbstring php-IDNA_Convert php-PHPMailer php-process php-simplepie php-xml php-mysql;
systemctl stop firewalld;
systemctl disable firewalld;
sestatus 0;
cp files/default_nginx.conf /etc/nginx/conf.d/default.conf;
cp files/default_httpd.conf /etc/httpd/conf.d/main.conf;
cp files/httpd.conf /etc/httpd/conf/httpd.conf;
systemctl restart httpd;
systemctl restart nginx;
chown -R apache.apache /var/www/html;
systemctl enable nginx --now;
systemctl enable httpd --now;

# Install MySQL Master
yum install -y http://dev.mysql.com/get/mysql80-community-release-el7-6.noarch.rpm; 
rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql-2022;
yum install -y mysql-community-server mysql-community-client MySQL-python
systemctl enable mysqld --now;
password_match=`awk '/A temporary password is generated for/ {a=$0} END{ print a }' /var/log/mysqld.log | awk '{print $(NF)}'`;
cp files/my_master.cnf /etc/my.cnf;
systemctl restart mysqld;
mysql -uroot -p$password_match --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Hunter1981!'; flush privileges; ";
mysql -uroot -pHunter1981! -e "CREATE USER 'replication_user'@'%' IDENTIFIED WITH mysql_native_password BY 'Hunter1981!'; GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%'; FLUSH PRIVILEGES; CREATE DATABASE wordpress; CREATE USER 'wordpress'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PassW0rd1!'; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost'; FLUSH PRIVILEGES;";
for s in `ls -1 /root/backupdb/wordpress`;
 do
 echo "--> $s restoring... ";
 zcat /root/backupdb/wordpress/$s | /usr/bin/mysql --user='root' --password='Hunter1981!' wordpress;
done

# Install wordpress
curl -LO https://wordpress.org/latest.tar.gz;
tar -xzvf latest.tar.gz;
cp -R wordpress/* /var/www/html/
cp files/wp-config.php /var/www/html/wp-config.php
/usr/bin/find /var/www/html/ -type d -exec chmod 750 {} \\;
/usr/bin/find /var/www/html/ -type f -exec chmod 640 {} \\;

# Install Filebeat
yum -y install filebeat/filebeat_7.17.3_x86_64-224190-4c3205.rpm;
cp filebeat/filebeat.yml /etc/filebeat/filebeat.yml;
systemctl enable filebeat --now;

# Install Node Exporter
useradd -d /dev/null -s /usr/sbin/nologin node_exporter;
mkdir /etc/node_exporter;
chown node_exporter.node_exporter /etc/node_exporter;
######mkdir /usr/local/bin/node_exporter;
#####chown node_exporter.node_exporter /usr/local/bin/node_exporter/*;
cp files/node_exporter /usr/local/bin/;
chown node_exporter.node_exporter /usr/local/bin/node_exporter;
cp files/node_exporter.service /etc/systemd/system/node_exporter.service;
systemctl enable node_exporter --now;
