#!/bin/bash
# Install httpd
yum -y install epel-release yum-utils;
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm;
yum-config-manager --enable remi-php72;
yum -y update;
yum -y install httpd php-mcrypt php-cli php-gd php-curl php-ldap php-zip php-fileinfo php php72 php-fpm php-mbstring php-IDNA_Convert php-PHPMailer php-process php-simplepie php-xml php-mysql;
systemctl stop firewalld;
systemctl disable firewalld;
sestatus 0;
cp files/default_httpd.conf /etc/httpd/conf.d/main.conf;
cp files/httpd.conf /etc/httpd/conf/httpd.conf;
systemctl restart httpd;
chown -R apache.apache /var/www/html;
systemctl enable httpd --now;

# Install SQL-Server Slave
yum install -y http://dev.mysql.com/get/mysql80-community-release-el7-6.noarch.rpm; 
rpm --import http://repo.mysql.com/RPM-GPG-KEY-mysql-2022;
yum install -y mysql-community-server mysql-community-client MySQL-python;
systemctl enable mysqld --now;
password_match=`awk '/A temporary password is generated for/ {a=$0} END{ print a }' /var/log/mysqld.log | awk '{print $(NF)}'`;
mysql -uroot -p$password_match --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Hunter1981!'; flush privileges; ";
cp files/my_slave.cnf /etc/my.cnf;
systemctl restart mysqld;
mysql -uroot -pHunter1981! -e "SET @@GLOBAL.read_only = ON; CHANGE REPLICATION SOURCE TO SOURCE_HOST='192.168.56.117', SOURCE_USER='replication_user', SOURCE_PASSWORD='Hunter1981!', SOURCE_AUTO_POSITION=1; start replica;";

# Install worpress
curl -LO https://wordpress.org/latest.tar.gz;
tar -xzvf latest.tar.gz;
cp -R wordpress/* /var/www/html/
cp files/wp-config.php /var/www/html/wp-config.php
/usr/bin/find /var/www/html/ -type d -exec chmod 750 {} \\;
/usr/bin/find /var/www/html/ -type f -exec chmod 640 {} \\;

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

