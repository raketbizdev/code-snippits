#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# run the command below
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/create-apache2-subdomain.sh; sudo chmod 755 create-apache2-subdomain.sh; ./create-apache2-subdomain.sh;

echo 'create a subdomain folder'
echo 'enter subdomain name:'
read subdomain
sudo mkdir /var/www/html/${subdomain}
echo '${subdomain} has been created.'
echo 'change user'
sudo chown $USER:$USER /var/www/html/${subdomain}
sudo mkdir /var/www/html/${subdomain}/public
sudo touch /var/www/html/${subdomain}/public/index.html
sudo chown $USER:$USER /var/www/html/${subdomain}/public/index.html

sudo cat >>  /var/www/html/${subdomain}/public/index.html <<EOL
        <h1>${subdomain} Test working</h1>
EOL
echo 'create a virtualhost'
sudo touch /var/www/html/${subdomain}/${subdomain}.conf
sudo chown $USER:$USER /var/www/html/${subdomain}/${subdomain}.conf

sudo cat >> /var/www/html/${subdomain}/${subdomain}.conf <<EOL
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/${subdomain}/public/

        ServerName ${subdomain}
      
        DirectoryIndex index.html index.cgi index.php

        <Directory /var/www/html/${subdomain}/public/>
                Options Indexes FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>

        ErrorLog $\{APACHE_LOG_DIR}/error.log
        CustomLog $\{APACHE_LOG_DIR}/access.log combined

</VirtualHost>
EOL
sudo ln -nfs "/var/www/html/${subdomain}/${subdomain}.conf" "/etc/apache2/sites-enabled/${subdomain}.conf"
sudo cat /var/www/html/${subdomain}/${subdomain}.conf
echo 'end of the commanline'
echo 'deleting shell script'

sudo service apache2 restart
sudo a2ensite /var/www/html/${subdomain}/${subdomain}.conf
sudo rm create-apache2-subdomain.sh
