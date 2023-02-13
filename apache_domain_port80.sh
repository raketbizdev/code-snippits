#!/bin/bash
#author: ruel nopal
# url: rnopal.com
# run this command below
# bash <(curl -s https://raw.githubusercontent.com/raketbizdev/code-snippits/master/ss_domain_config.sh)

# Function to validate FQDN
function is_valid_fqdn() {
    local domain=$1
    local re="^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$"
    if [[ $domain =~ $re ]]; then
        return 0
    else
        return 1
    fi
}

# Prompt for domain name
while true; do
    read -p "Enter the domain name (e.g. example.com): " domain
    if is_valid_fqdn "$domain"; then
        break
    else
        echo "Invalid domain name. Please enter a fully qualified domain name (FQDN)."
    fi
done

# Create the document root directory
sudo mkdir -p /var/www/$domain

# Grant ownership of the document root to the Apache user
sudo chown -R www-data:www-data /var/www/$domain

# Create a sample index.html file
echo "<html><head><title>Welcome to $domain</title></head><body><h1>Success! The virtual host is working!</h1></body></html>" | sudo tee /var/www/$domain/index.html

# Create a virtual host configuration file
sudo bash -c "cat > /etc/apache2/sites-available/$domain.conf <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@$domain
    ServerName $domain
    ServerAlias www.$domain
    DocumentRoot /var/www/$domain
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF"

# Enable the virtual host
sudo a2ensite $domain.conf

# Restart Apache to apply changes
sudo service apache2 restart
