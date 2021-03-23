#!/bin/bash

echo "PROVISIONING SCRIPT"
echo "-------------------------------------------"
echo " "
echo "INSTALL ANSIBLE"
echo "1. Adding repository."
sudo apt-add-repository ppa:ansible/ansible -y
echo "2. Running apt update."
apt update -y
echo "3. Installing Ansible and Git Package."
apt install ansible git -y
echo "4. Install basic tools."
sudo apt-get install -yq build-essential python-pip
echo "Done."

echo " "

echo "ADDING LOCALHOST TO ANSIBLE CONFIG"
echo " " >> /etc/ansible/hosts
echo "[local]" >> /etc/ansible/hosts
echo "localhost ansible_user=root" >> /etc/ansible/hosts
echo "Done."

echo " "

echo "SETING UP SELF-ACCESS FROM ANSIBLE"
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config ; service ssh restart
mv /tmp/playbooks /etc/ansible/
mv /tmp/.vault /etc/ansible
echo "Done."

echo " "

echo "APPLYING PLAYBOOKS"
echo "1. Installing softwares"
ansible-playbook /etc/ansible/playbooks/playbook-setupServer/playbook-setupServer.yml
echo "2. Setting up Wordpress"
ansible-playbook /etc/ansible/playbooks/playbook-setupWordpress/playbook-setupWordpress.yml --vault-password-file=/etc/ansible/.vault