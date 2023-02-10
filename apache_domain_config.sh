#!/bin/bash

#author: ruel nopal
# url: rnopal.com
# run this command below
# bash <(curl -s https://raw.githubusercontent.com/raketbizdev/code-snippits/master/domains_config.sh)

# Function to validate domain name
function validate_domain {
  domain=$1
  # Check if domain is a valid FQDN
  if [[ $domain =~ ^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$ ]]; then
    return 0
  else
    return 1
  fi
}

# Prompt the user to enter the domain name
while true; do
  read -p "Enter the domain name: " domain
  if validate_domain $domain; then
    break
  else
    echo "Invalid domain name, please enter a valid fully qualified domain name (FQDN)"
  fi
done

# Install certbot if not already installed
if ! [ -x "$(command -v certbot)" ]; then
  sudo apt-get update
  sudo snap install core; sudo snap refresh core
  sudo snap install --classic certbot
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
  sudo certbot --apache
fi

# Create the document root directory
sudo mkdir -p /var/www/$domain/public_html

# Give ownership of the directory to the Apache user
sudo chown -R $USER:www-data /var/www/$domain/public_html

# Set the correct permissions on the directory
sudo chmod -R 755 /var/www/$domain/public_html

# Create the virtual host configuration file for port 80
sudo touch /etc/apache2/sites-available/$domain.conf
sudo echo "<VirtualHost *:80>
  ServerAdmin admin@$domain
  ServerName $domain
  ServerAlias www.$domain
  DocumentRoot /var/www/$domain/public_html
  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/$domain.conf

# Enable the virtual host
sudo a2ensite $domain.conf

# Obtain SSL certificate using certbot
sudo certbot --apache -d $domain -d www.$domain

# Create the virtual host configuration file for port 443
sudo touch /etc/apache2/sites-available/$domain-ssl.conf
sudo echo "<IfModule mod_ssl.c>
  <VirtualHost *:443>
    ServerAdmin admin@$domain
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot /var/www/$domain/public_html
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    
    SSLEngine on
    SSLCertificateFile /etc/letsencrypt/live/$domain/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/$domain/privkey.pem
    
    <Directory /var/www/$domain/public_html/>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
    </Directory>   
  </VirtualHost>
</IfModule>" > /etc/apache2/sites-available/$domain-ssl.conf

# Enable the virtual host for SSL
sudo a2ensite $domain-ssl.conf

# Restart Apache to apply changes
sudo service apache2 restart
