#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# facebook: https://www.facebook.com/raketbizdev/
# Need a partime devops please contact me.
# make sure you already set up your domain to point to your server 
# Tested in Digitalocean Server Ubunto 20.04 LTS
# Remember to share if you like this script
# Run the command below

# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/nginx-subdomain-setup.sh; sudo chmod 755 nginx-subdomain-setup.sh; ./nginx-subdomain-setup.sh;

echo -e '\e[33 create a subdomain folder'
echo -e '\e[33 enter subdomain name:'
read subdomain
root_dir="${1:-${PWD}}"
echo $root_dir
sudo mkdir $root_dir/${subdomain}
echo -e '\e[33 ${subdomain} has been created.'
echo -e '\e[33 change user'
sudo chown $USER:$USER $root_dir/${subdomain}
sudo mkdir $root_dir/${subdomain}/public
sudo touch $root_dir/${subdomain}/public/index.html
sudo chown $USER:$USER $root_dir/${subdomain}/public/index.html

sudo cat >>  $root_dir/${subdomain}/public/index.html <<EOL
  <html>
      <head>
          <title>Welcome to ${subdomain}!</title>
      </head>
      <body>
          <h1>Success!  The ${subdomain} virtual host is working!</h1>
      </body>
  </html>
EOL

echo -e '\e[33 creating a virtualhost'
sudo touch $root_dir/${subdomain}/${subdomain}.conf
sudo chown $USER:$USER $root_dir/${subdomain}/${subdomain}.conf
if which certbot >/dev/null; then
    echo exists
    echo -e '\e[33 Cerbot already been install proceed to install cerbot'
    sudo certbot certonly --nginx -d ${subdomain}
else
    echo does not exist
    echo -e '\e[33 Installing Cerbot letsencrypt'
    sudo apt-get update
    sudo apt-get install software-properties-common
    sudo add-apt-repository universe
    sudo apt-get update
    sudo apt-get install certbot python3-certbot-nginx
    sudo certbot certonly --nginx -d ${subdomain}
fi

sudo cat >> $root_dir/${subdomain}/${subdomain}.conf <<EOL
server {
        listen 80;

        root $root_dir/${subdomain}/public;
        index index.html index.htm index.nginx-debian.html;
        server_name ${subdomain};

        location / {
                try_files \$uri \$uri/ =404;
        }
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    root ${root_dir}/${subdomain}/public;
    server_name ${subdomain};

    ssl_certificate /etc/letsencrypt/live/${subdomain}/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/${subdomain}/privkey.pem;

    # curl https://ssl-config.mozilla.org/ffdhe2048.txt > /path/to/dhparam
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    # intermediate configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    # HSTS (ngx_http_headers_module is required) (63072000 seconds)
    add_header Strict-Transport-Security "max-age=63072000" always;

    # OCSP stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    location / {
            try_files \$uri \$uri/ =404;
    }
}
EOL
sudo ln -nfs "${root_dir}/${subdomain}/${subdomain}.conf" "/etc/nginx/sites-enabled/${subdomain}.conf"
sudo cat $root_dir/${subdomain}/${subdomain}.conf
sudo nginx -t
sudo systemctl restart nginx
echo -e '\e[33 end of the commanline'
echo -e '\e[33 deleting shell script'

echo -e '\e[33 deleting nginx-subdomain-setup.sh'
echo -e '\e[33 if you like this script dont forget to spread the word and give a beer to this man.'
echo -e '\e[33 my paypal \e[5https://paypal.me/freelancerdad'
echo -e '\e[33 Enjoy happy coding'
echo 'visit ${subdomain}'
sudo rm nginx-subdomain-setup.sh
