
#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal Consulting.
# url: www.ruelnopal.com

sudo apt update
sudo ufw app info "Apache Full"
sudo apt install curl
curl http://icanhazip.com
sudo apt install mysql-server
sudo mysql_secure_installation
sudo apt install php libapache2-mod-php php-mysql
sudo apt install php-cli
sudo apt update
sudo apt install phpmyadmin php-mbstring php-gettext
