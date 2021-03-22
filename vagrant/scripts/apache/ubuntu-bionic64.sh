 #!/bin/bash
 

echo "UBUNTU BIONIC64 - APACHE"
echo "1. Running apt-update."
sudo apt update -y
echo "2. Installing Apache"
sudo apt install apache2 -y
echo "3. Starting and enabling service."
sudo systemctl start apache2 && sudo systemctl enable apache2
echo "4. Enabling mods"
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_connect
a2enmod rewrite
echo "Done."

echo " "

echo "WORDPRESS APACHE CONFIG"
echo "1. Moving vhost"
mv /tmp/default-vhost-example.conf /etc/apache2/sites-available
echo "2. Enabling vhost"
a2ensite default-vhost-example.conf ; a2dissite 000-default.conf
echo "3. Reloading Apache"
service apache2 reload
echo "Done."