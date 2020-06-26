#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# run the command below
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/nginx-subdomain-setup.sh; sudo chmod 755 nginx-subdomain-setup.sh; ./nginx-subdomain-setup.sh;

echo -e '\e[33create a subdomain folder'
echo -e '\e[33enter subdomain name:'
read subdomain
sudo mkdir /var/www/html/${subdomain}
echo -e '\e[33${subdomain} has been created.'
echo -e '\e[33change user'
sudo chown $USER:$USER /var/www/html/${subdomain}
sudo mkdir /var/www/html/${subdomain}/public
sudo touch /var/www/html/${subdomain}/public/index.html
sudo chown $USER:$USER /var/www/html/${subdomain}/public/index.html

sudo cat >>  /var/www/html/${subdomain}/public/index.html <<EOL
  <html>
      <head>
          <title>Welcome to ${subdomain}!</title>
      </head>
      <body>
          <h1>Success!  The ${subdomain} virtual host is working!</h1>
      </body>
  </html>
EOL

echo -e '\e[33creating a virtualhost'
sudo touch /var/www/html/${subdomain}/${subdomain}.conf
sudo chown $USER:$USER /var/www/html/${subdomain}/${subdomain}.conf
IP="curl http://checkip.amazonaws.com"
GETIP="echo ${IP}"
if which certbot >/dev/null; then
    echo exists
    echo -e '\e[33Cerbot already been install proceed to install cerbot'
    sudo certbot certonly --nginx -d ${subdomain}
else
    echo does not exist
    echo -e '\e[33Installing Cerbot letsencrypt'
    sudo apt-get update
    sudo apt-get install software-properties-common
    sudo add-apt-repository universe
    sudo apt-get update
    sudo apt-get install certbot python3-certbot-nginx
    sudo certbot certonly --nginx -d ${subdomain}
fi

sudo cat >> /var/www/html/${subdomain}/${subdomain}.conf <<EOL
server {
    listen 80;
    listen [::]:80;
    server_name ${subdomain};
    root /var/www/html/${subdomain}/public
    return 301 https://\$host\$request_uri;
    
    location / {
              try_files \$uri \$uri/ =404;
    }
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    root /var/www/html/${subdomain}/public;
    server_name ${subdomain};

    ssl_certificate /etc/letsencrypt/live/${subdomain}/fullchain.pem;
    ssl_certificate_key  /etc/letsencrypt/live/${subdomain}/privkey.pem;
    ssl_session_timeout 1d;
    ssl_session_cache shared:MozSSL:10m;  # about 40000 sessions
    ssl_session_tickets off;

    # curl https://ssl-config.mozilla.org/ffdhe2048.txt > /path/to/dhparam
    ssl_dhparam /etc/letsencrypt/certs/dhparam.pem;

    # intermediate configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    # HSTS (ngx_http_headers_module is required) (63072000 seconds)
    add_header Strict-Transport-Security "max-age=63072000" always;

    # OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;

    # verify chain of trust of OCSP response using Root CA and Intermediate certs
    # ssl_trusted_certificate /path/to/root_CA_cert_plus_intermediates;

    # replace with the IP address of your resolver
    # resolver ${GETIP};
    location / {
                try_files \$uri \$uri/ =404;
    }
}
EOL
sudo ln -nfs "/var/www/html/${subdomain}/${subdomain}.conf" "/etc/nginx/sites-enabled/${subdomain}.conf"
sudo cat /var/www/html/${subdomain}/${subdomain}.conf
sudo systemctl restart nginx
echo -e '\e[33end of the commanline'
echo -e '\e[33deleting shell script'

echo -e '\e[33deleting nginx-subdomain-setup.sh'
echo -e '\e[33if you like this script dont forget to spread the word and give a beer to this man.'
echo -e '\e[33my paypal \e[5https://paypal.me/freelancerdad'
echo -e '\e[33Enjoy happy coding'
sudo rm nginx-subdomain-setup.sh
