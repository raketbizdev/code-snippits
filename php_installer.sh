#!/bin/bash

# Define variables
LAMP_REPO="lamp-mariadb10.4-php"
HTTPD_SERVICE="apache2"
APACHE_GROUP="www-data"
WEB_ROOT="/var/www"
PHP_INFO="<?php phpinfo(); ?>"

# Update system packages
if ! apt-get update -y; then
  echo "Failed to update system packages."
  exit 1
fi

# Install LAMP stack
if ! apt-get install -y $LAMP_REPO; then
  echo "Failed to install LAMP stack."
  exit 1
fi

# Install Apache and MariaDB
if ! apt-get install -y $HTTPD_SERVICE mariadb-server; then
  echo "Failed to install Apache and MariaDB."
  exit 1
fi

# Check if web root exists and create it if it doesn't
if [ ! -d $WEB_ROOT ]; then
  if ! mkdir $WEB_ROOT; then
    echo "Failed to create web root."
    exit 1
  fi
fi

# Set ownership and permissions for web root
if ! chown -R $USER:$APACHE_GROUP $WEB_ROOT; then
  echo "Failed to set ownership for web root."
  exit 1
fi

if ! chmod 2775 $WEB_ROOT; then
  echo "Failed to set permissions for web root."
  exit 1
fi

if ! find $WEB_ROOT -type d -exec chmod 2775 {} \; ; then
  echo "Failed to set directory permissions for web root."
  exit 1
fi

if ! find $WEB_ROOT -type f -exec chmod 0664 {} \; ; then
  echo "Failed to set file permissions for web root."
  exit 1
fi

# Create PHP info file
if ! echo "$PHP_INFO" > "$WEB_ROOT/html/phpinfo.php"; then
  echo "Failed to create PHP info file."
  exit 1
fi

echo "LAMP stack installation completed successfully."
