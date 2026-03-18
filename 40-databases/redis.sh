#!/bin/bash

dnf install ansible -y

cd /home/ec2-user

# Remove old clone to always get fresh code
rm -rf Ansible-role-roboshop-tf

git clone https://github.com/sundeep-balaveni/Ansible-role-roboshop-tf.git

cd Ansible-role-roboshop-tf

ansible-playbook -i inventory.ini redis.yml