#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Creating users
# run this
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/create-apache2-subdomain.sh; sudo chmod 755 create-apache2-subdomain.sh; ./create-apache2-subdomain.sh;

echo 'create a subdomain folder'
echo 'enter subdomain name:'
read subdomain
sudo mkdir /var/www/html/${subdomain}
echo '${subdomain} has been created.'
echo 'change user'
sudo chown $USER:$USER /var/www/html/${subdomain}

echo 'create a virtualhost'
sudo touch /etc/apache2/sites-available/${subdomain}.conf
cat <<EOT >> ${subdomain}.conf
'<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/${subdomain}/public/

        ServerName ${subdomain}
      
        DirectoryIndex index.php

        <Directory /var/www/html/${subdomain}/public/>
                Options Indexes FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/${subdomain}.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>'
EOT
echo 'end of the commanline'
echo 'deleting shell script'
sudo cat /etc/apache2/sites-available/${subdomain}.conf
sudo service apache2 restart
a2ensite /etc/apache2/sites-available/${subdomain}.conf
sudo rm create-apache2-subdomain.sh

