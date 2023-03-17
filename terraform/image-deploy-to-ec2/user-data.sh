#! /usr/bin/bash

sudo yum update -y
sudo yum install -y docker
usermod -aG docker ec2-user
chmod 666 /var/run/docker.sock
systemctl start docker
systemctl enable docker
docker --version
