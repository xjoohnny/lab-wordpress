#!/bin/bash


echo "CENTOS 7 - ANSIBLE"
echo "1. Installing Ansible Package"
sudo yum install -y ansible
echo "Done."

echo "ADDING LOCALHOST TO ANSIBLE CONFIG"
echo " " >> /etc/ansible/hosts
echo "[local]" >> /etc/ansible/hosts
echo "localhost ansible_user=root" >> /etc/ansible/hosts
mv /tmp/playbooks /etc/ansible/
echo "Done."

echo "SETING UP SELF-ACCESS FROM ANSIBLE"
echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config ; systemctl restart ssh
echo "Done."

echo " "

echo "APPLYING PLAYBOOKS"
echo "1. Setting up Wordpress"
ansible-playbook /etc/ansible/playbooks/playbook-setupWordpress/playbook-setupWordpress.yml