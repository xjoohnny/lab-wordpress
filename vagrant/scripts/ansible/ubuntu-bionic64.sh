#!/bin/bash


echo "UBUNTU BIONIC64 - ANSIBLE"
echo "1. Adding repository."
sudo apt-add-repository ppa:ansible/ansible -y
echo "2. Running apt update."
apt update -y
echo "3. Installing Ansible Package."
apt install ansible -y
echo "Done."

echo " "

echo "ADDING LOCALHOST TO ANSIBLE CONFIG"
echo " " >> /etc/ansible/hosts
echo "[local]" >> /etc/ansible/hosts
echo "localhost ansible_user=root" >> /etc/ansible/hosts
mv /tmp/playbooks /etc/ansible/
echo "Done."

echo "SETING UP SELF-ACCESS FROM ANSIBLE"
echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config ; service ssh restart
mv /tmp/.vault /etc/ansible/
echo "Done."

echo " "

echo "APPLYING PLAYBOOKS"
echo "1. Setting up Wordpress"
ansible-playbook /etc/ansible/playbooks/playbook-setupWordpress/playbook-setupWordpress.yml --vault-password-file=/etc/ansible/.vault