#!/bin/bash

dnf install ansible -y

cd /home/ec2-user

# Remove old clone to always get fresh code
sudo rm -rf Ansible-role-roboshop-tf

git clone https://github.com/daws-88s/ansible-roboshop-roles-tf.git

git pull 

cd Ansible-role-roboshop-tf

#ds


ansible-playbook -i inventory.ini catalogue.yml  -vvv  