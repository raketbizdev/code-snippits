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
root_dir="`pwd`"
echo $root_dir
sudo chown $USER:$USER $root_dir/${subdomain}
sudo mkdir $root_dir/${subdomain}/public
sudo touch $root_dir/${subdomain}/public/index.html
sudo chown $USER:$USER $root_dir/${subdomain}/public/index.html

sudo cat >>  $root_dirD/${subdomain}/public/index.html <<EOL
        <h1>${subdomain} Test working</h1>
EOL
echo 'create a virtualhost'
sudo touch $root_dir/${subdomain}/${subdomain}.conf
sudo chown $USER:$USER $root_dir/${subdomain}/${subdomain}.conf

sudo cat >> $root_dir/${subdomain}/${subdomain}.conf <<EOL
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot $root_dirD/${subdomain}/public

        ServerName ${subdomain}
      
        DirectoryIndex index.html index.cgi index.php

        <Directory $root_dir/${subdomain}/public/>
                Options Indexes FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/${subdomain}.error.log
        CustomLog \${APACHE_LOG_DIR}/${subdomain}.access.log combined

</VirtualHost>
EOL
sudo ln -nfs "$root_dir/${subdomain}/${subdomain}.conf" "/etc/apache2/sites-enabled/${subdomain}.conf"
sudo cat $root_dirD/${subdomain}/${subdomain}.conf
sudo systemctl restart apache2
sudo a2ensite $root_dir/${subdomain}/${subdomain}.conf
echo 'end of the commanline'
echo 'deleting shell script'
sudo rm create-apache2-subdomain.sh


