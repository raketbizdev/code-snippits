  
#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# run the command below
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/oneclick-apache-vhost-create.sh; sudo chmod 755 oneclick-apache-vhost-create.sh; ./oneclick-apache-vhost-create.sh;

echo 'create a subdomain folder'
echo 'enter subdomain name:'
read subdomain
sudo touch ${subdomain}.conf
sudo chown $USER:$USER ${subdomain}.conf
root_dir="${1:-${PWD}}"
sudo cat >> ${subdomain}.conf <<EOL
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  ServerName ${subdomain}       
</VirtualHost>
<VirtualHost *:443>
  ServerName ${subdomain} 
  DocumentRoot ${dir_root}/public

  ErrorLog \${APACHE_LOG_DIR}/${subdomain}.error.log
  CustomLog \${APACHE_LOG_DIR}/${subdomain}.access.log combined

  DirectoryIndex index.html index.cgi index.php
  <Directory $dir_root/>
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
sudo ln -nfs "$dir_root/${subdomain}.conf" "/etc/apache2/sites-enabled/${subdomain}.conf"
sudo systemctl restart apache2
echo 'end of the commanline'
echo 'deleting shell script'
sudo rm oneclick-apache-vhost-create.sh
