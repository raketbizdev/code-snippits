  
#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# facebook: https://www.facebook.com/raketbizdev/
# Need a partime devops please contact me.
# Tested in Digitalocean Server Ubunto 20.04 LTS
# Remember to share if you like this script
# Run the command below

# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/one-click-install-kibana-with-nginx.sh sudo chmod 755 one-click-install-kibana-with-nginx.sh; ./one-click-install-kibana-with-nginx.sh

java -version
sudo apt install apt-transport-https nginx
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update && sudo apt install kibana
sudo nano /etc/kibana/kibana.yml
# add this to kibana.yml server.host: "localhost"
sudo systemctl restart kibana

echo -e '\e[33 create username for kiban'
echo -e '\e[33 enter username:'
read username
echo -e '\e[33 create password for kiban'
echo -e '\e[33 enter password:'
read password
echo "admin:`${username} passwd -apr1 ${password}`" | sudo tee -a /etc/nginx/htpasswd.kibana

echo -e '\e[33 create subdomain for kibana'
echo -e '\e[33 enter subdomain:'
read subdomain

sudo touch /etc/nginx/sites-available/${subdomain}.conf
sudo chown $USER:$USER /etc/nginx/sites-available/${subdomain}.conf

sudo cat >>  /etc/nginx/sites-available/${subdomain}.conf <<EOL
server {
        listen 80;

        server_name ${subdomain};

        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/htpasswd.kibana;

        location / {
            proxy_pass http://localhost:5601;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;        
        }
    }
EOL
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/${subdomain}.conf /etc/nginx/sites-enabled/${subdomain}.conf
sudo nginx -t
sudo systemctl restart nginx
sudo apt install logstash
sudo rm one-click-install-kibana-with-nginx.sh
