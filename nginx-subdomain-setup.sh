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
    root /var/www/html/${subdomain}/public;
    # return 301 https://\$host\$request_uri;
    
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
