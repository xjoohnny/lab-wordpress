#!/bin/bash


echo "CENTOS 7 - DOCKER"
echo "1. Installing dependencies."
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
echo "2. Adding repository."
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo "3. Installing Docker Packages."
sudo yum install docker-ce docker-ce-cli containerd.io -y
echo "4. Starting and enabling service."
sudo systemctl start docker && sudo systemctl enable docker
echo "5. Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "Done."