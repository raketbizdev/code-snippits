#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal Consulting.
# url: www.ruelnopal.com
# Installing Apache in AWS inctance.

echo "Make sure you are a sudo user"
cd /
sudo apt update
sudo apt install apache2
sudo ufw app list
echo "Check if theres no error"
sudo systemctl status apache2
echo "Visit IP address below to check if works."
curl http://checkip.amazonaws.com
echo "Deleting Shell files."
sudo rm -rf auto-install-apache2-aws.sh
