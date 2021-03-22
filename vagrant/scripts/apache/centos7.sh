#!/bin/bash


echo "CENTOS 7 - HTTPD"
echo "1. Running 'yum update'"
sudo yum update -y
echo "2. Installing Httpd Package"
sudo yum install httpd -y
echo "3. Starting and enabling service."
sudo systemctl start httpd && sudo systemctl enable httpd
echo "4. Enabling mods"
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_connect
a2enmod rewrite
echo "Done."

echo " "
echo "WORDPRESS APACHE CONFIG"
echo "1. Moving vhost"
mv /tmp/default-vhost-example.conf /etc/httpd/sites-available
echo "2. Enabling vhost"
a2ensite default-vhost-example.conf ; a2dissite 000-default.conf
echo "3. Reloading Apache"
systemctl reload httpd
echo "Done."