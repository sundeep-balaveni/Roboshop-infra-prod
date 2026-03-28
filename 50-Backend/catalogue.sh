#!/bin/bash

# dnf install ansible -y

# cd /home/ec2-user

# # Remove old clone to always get fresh code
# sudo rm -rf Ansible-role-roboshop-tf

# git clone https://github.com/daws-88s/ansible-roboshop-roles-tf.git

# git pull 

# cd ansible-roboshop-roles-tf


# #ds




# ansible-playbook -i inventory.ini catalogue.yml  -vvv  




#!/bin/bash

component=$1
environment=$2
app_version=$3
dnf install ansible -y

cd /home/ec2-user
git clone https://github.com/sundeep-balaveni/Ansible-role-roboshop-tf.git

cd ansible-roboshop-roles-tf
git pull
ansible-playbook -e component=$component -e env=$environment -e app_version=$app_version roboshop.yaml
