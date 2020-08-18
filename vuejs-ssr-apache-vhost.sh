#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# run the command below
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/vuejs-ssr-apache-vhost.sh; sudo chmod 755 vuejs-ssr-apache-vhost.sh; ./vuejs-ssr-apache-vhost.sh;
echo 'create a subdomain folder'
echo 'enter subdomain name:'
read subdomain
echo 'Create disignated port'
echo 'enter port number ex: 3000:'
read port_num
sudo touch ${subdomain}.conf
sudo chown $USER:$USER ${subdomain}.conf
root_dir="${1:-${PWD}}"
echo $dir_root
sudo cat >> ${subdomain}.conf <<EOL
<VirtualHost *:80>
    ServerName development.bigbenta.com
    Redirect permanent / https://${subdomain}/
    DirectoryIndex index.html
</VirtualHost>

<VirtualHost *:443>
	ServerAdmin support@bigbenta.com
	DocumentRoot  \${dir_root}
	DirectoryIndex index.html
	ServerName ${subdomain}


  ErrorLog \${APACHE_LOG_DIR}/${subdomain}-error.log
  CustomLog \${APACHE_LOG_DIR}/${subdomain}-access.log combined

  # Example SSL configuration
  SSLEngine on
  SSLProtocol all -SSLv2
  SSLCipherSuite HIGH:MEDIUM:!aNULL:!MD5
  Include /etc/letsencrypt/options-ssl-apache.conf
  SSLCertificateFile      /etc/letsencrypt/live/${subdomain}/fullchain.pem
  SSLCertificateKeyFile   /etc/letsencrypt/live/${subdomain}/privkey.pem
  

	ProxyPreserveHost On
            <Proxy *>
                Order allow,deny
                Allow from all
            </Proxy>
        ProxyPass / https://${subdomain}:${port_num}/
        ProxyPassReverse / https://${subdomain}:${port_num}/
</VirtualHost>
EOL
sudo ln -nfs "$dir_root/${subdomain}.conf" "/etc/apache2/sites-enabled/${subdomain}.conf"
sudo systemctl restart apache2
echo 'end of the commanline'
echo 'deleting shell script'
sudo rm vuejs-ssr-apache-vhost.sh
