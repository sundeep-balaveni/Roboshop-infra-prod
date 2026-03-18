#!/bin/bash

dnf install ansible -y

cd /home/ec2-user

git clone https://github.com/sundeep-balaveni/Ansible-role-roboshop-tf.git

git pull https://github.com/sundeep-balaveni/Ansible-role-roboshop-tf.git

cd Ansible-role-roboshop-tf

ansible-playbook -i inventory.ini mongo.yml

