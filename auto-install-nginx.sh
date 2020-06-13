#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Installing NginX.
#
# apt update && apt upgrade
# apt install wget
# run wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/auto-install-nginx.sh; sudo chmod 755 auto-install-nginx.sh; ./auto-install-nginx.sh
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
