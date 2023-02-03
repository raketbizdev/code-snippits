#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# run the command below
# bash <(curl -s https://raw.githubusercontent.com/raketbizdev/code-snippits/master/create-apache2-subdomain.sh)

subdomain=""
root_dir="${1:-${PWD}}"

install_dependencies() {
  echo 'Checking for Apache installation...'
  if ! [ -x "$(command -v apache2)" ]; then
    echo 'Apache is not installed. Installing Apache...'
    sudo apt-get update
    sudo apt-get install apache2
  fi

  echo 'Checking for Certbot installation...'
  if ! [ -x "$(command -v certbot)" ]; then
    echo 'Certbot is not installed. Installing Certbot...'
    sudo apt-get install certbot python3-certbot-apache
  fi
}

create_subdomain_folder() {
  echo 'Creating subdomain folder...'
  echo 'Enter subdomain name:'
  read subdomain

  sudo mkdir "$subdomain"
  sudo chown "$USER:$USER" "$subdomain"

  echo "${subdomain} has been created."
  echo 'Change user...'
}

create_public_folder() {
  sudo mkdir "${subdomain}/public"
  sudo touch "${subdomain}/public/index.html"
  sudo chown "$USER:$USER" "${subdomain}/public/index.html"
}

create_ssl_certificate() {
  while true; do
    read -p "Enter a valid domain or subdomain name: " subdomain

    if [[ $subdomain =~ ^([a-zA-Z0-9]+(-[a-zA-Z0-9]+)*\.)+[a-zA-Z]{2,}$ ]]; then
      echo 'Creating SSL certificate...'
      sudo certbot certonly -d "$subdomain"
      break
    else
      echo "Invalid domain or subdomain name. Please enter a valid one."
    fi
  done
}

create_virtualhost_file() {
  echo 'Creating virtual host file...'
  sudo touch "${subdomain}/${subdomain}.conf"
  sudo chown "$USER:$USER" "${subdomain}/${subdomain}.conf"

  cat >> "${subdomain}/${subdomain}.conf" <<EOL
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  ServerName ${subdomain}
</VirtualHost>
<VirtualHost *:443>
  ServerName ${subdomain}
  DocumentRoot ${root_dir}/${subdomain}/public
  ErrorLog \${APACHE_LOG_DIR}/${subdomain}.error.log
  CustomLog \${APACHE_LOG_DIR}/${subdomain}.access.log combined
  DirectoryIndex index.html index.cgi index.php
  <Directory ${root_dir}/${subdomain}/public/>
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
  sudo cat "${root_dir}/${subdomain}/${subdomain}.conf"
}

main() {
  install_dependencies

  create_subdomain_folder
  create_public_folder
  create_ssl_certificate
  create_virtualhost_file

  echo 'Restarting Apache service...'
  sudo systemctl restart apache2

  echo 'End of the command line'
  echo 'Deleting shell script...'
  sudo rm "$0"
}
main
