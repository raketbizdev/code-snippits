#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Installing Elasticsearch to aws instance.

# change version before running.
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/install_elasticsearch.sh; sudo chmod 755 install_elasticsearch.sh; ./install_elasticsearch.sh
java -version

echo $JAVA_HOME
# if not available add java home to .bash_profile

export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

export PATH=$PATH:/usr/lib/jvm/java-1.11.0-openjdk-amd64

sudo apt-get install apt-transport-https
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main"

sudo apt-get update
sudo apt-get install elasticsearch

sudo nano /etc/elasticsearch/elasticsearch.yml

 network.host: 0.0.0.0
 cluster.name: myCluster1
 node.name: "myNode1"
 
 sudo /bin/systemctl enable elasticsearch.service
 sudo -i service elasticsearch stop
 curl localhost:9200
 sudo rm -rf install_elasticsearch.sh
