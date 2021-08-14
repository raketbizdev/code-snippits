#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Installing Elasticsearch to aws instance.

# change version before running.
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/install_elasticsearch.sh; sudo chmod 755 install_elasticsearch.sh; ./install_elasticsearch.sh
sudo apt install openjdk-8-jre-headless 
java -version

echo $JAVA_HOME
# if not available add java home to .bash_profile

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

sudo apt-get install apt-transport-https
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main"

sudo apt-get update
sudo apt-get install elasticsearch

# sudo nano /etc/elasticsearch/elasticsearch.yml

# network.host: 127.0.0.1
# cluster.name: myCluster1
# node.name: myNode1
 
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service

echo "Note! Elasticsearch Need 2GB of RAM per node"
curl -X GET 'http://localhost:9200'
sudo rm -rf install_elasticsearch.sh
