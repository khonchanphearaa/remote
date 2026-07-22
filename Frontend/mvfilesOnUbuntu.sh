#!/bin/bash

# For execute the files dist from scp.sh from local machine computer into Ubuntu.

echo "start ssh remote"
ssh minipc@YOUR_UBUNTU_IP

echo "trying scp files..."
sudo rm -rf /var/www/student-app/*
sudo cp -r ~/dist/* /var/www/student-app/
rm -rf ~/dist
sudo systemctl restart nginx
