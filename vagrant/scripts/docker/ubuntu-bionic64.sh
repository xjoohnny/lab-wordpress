#!/bin/bash


echo "UBUNTU BIONIC64 - DOCKER"
echo "1. Installing dependencies."
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
echo "2. Adding GPG Key."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "3. Adding repository."
sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'
echo "4. Running apt update."
sudo apt update -y
echo "5. Installing Docker Packages."
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
echo "6. Starting and enabling service."
sudo systemctl start docker && sudo systemctl enable docker
echo "7. Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-Linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "Done."