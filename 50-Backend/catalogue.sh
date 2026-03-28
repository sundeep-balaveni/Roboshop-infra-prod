#!/bin/bash

dnf install ansible -y

cd /home/ec2-user

# Remove old clone to always get fresh code
sudo rm -rf Ansible-role-roboshop-tf

git clone https://github.com/sundeep-balaveni/Ansible-role-roboshop-tf.git

git pull 

cd Ansible-role-roboshop-tf

ansible-playbook -i inventory.ini catalouge.yml  -vvv