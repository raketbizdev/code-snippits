#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# run the command below
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/create-apache2-subdomain.sh; sudo chmod 755 create-apache2-subdomain.sh; ./create-apache2-subdomain.sh;

echo 'create a subdomain folder'
echo 'enter subdomain name:'
read subdomain
root_dir="${1:-${PWD}}"
echo $root_dir
sudo mkdir ${subdomain}
echo "${subdomain} has been created."
echo 'change user'

sudo chown $USER:$USER ${subdomain}
sudo mkdir ${subdomain}/public
sudo touch ${subdomain}/public/index.html
sudo chown $USER:$USER ${subdomain}/public/index.html
echo 'creating ssl from certbot'
sudo certbot certonly -d ${subdomain}
sudo cat >>  ${subdomain}/public/index.html <<EOL
        <h1>${subdomain} Test working</h1>
EOL
echo 'create a virtualhost'
sudo touch ${subdomain}/${subdomain}.conf
sudo chown $USER:$USER ${subdomain}/${subdomain}.conf
sudo cat >> ${subdomain}/${subdomain}.conf <<EOL
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  ServerName ${subdomain}       
</VirtualHost>

<VirtualHost *:443>
  ServerName ${subdomain} 
  DocumentRoot $root_dir/${subdomain}/public
  ErrorLog \${APACHE_LOG_DIR}/${subdomain}.error.log
  CustomLog \${APACHE_LOG_DIR}/${subdomain}.access.log combined
  DirectoryIndex index.html index.cgi index.php
  <Directory $root_dir/${subdomain}/public/>
      Options Indexes FollowSymLinks
      AllowOverride All
      Require all granted
  </Directory>
  # Example SSL configuration
  SSLEngine on
  SSLProtocol all -SSLv2
  SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
  SSLCertificateFile /etc/letsencrypt/live/${subdomain}/fullchain.pem
  SSLCertificateKeyFile /etc/letsencrypt/live/${subdomain}/privkey.pem
</VirtualHost>
EOL
sudo ln -nfs "${root_dir}/${subdomain}/${subdomain}.conf" "/etc/apache2/sites-enabled/${subdomain}.conf"
sudo cat ${root_dir}/${subdomain}/${subdomain}.conf
sudo systemctl restart apache2
echo 'end of the commanline'
echo 'deleting shell script'
sudo rm create-apache2-subdomain.sh


