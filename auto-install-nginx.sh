#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Installing NginX.

echo "Make sure you are a sudo user"
cd /
sudo apt update
sudo apt install nginx
sudo ufw app list
echo "Check if theres no error"
sudo ufw allow 'Nginx HTTP'
sudo ufw status
systemctl status nginx
echo "Visit IP address below to check if works."
curl http://checkip.amazonaws.com
echo "Deleting Shell files."
sudo rm -rf auto-install-nginx.sh
