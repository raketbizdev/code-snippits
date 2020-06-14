#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Creating users

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm

rvm get stable --autolibs=enable
usermod -a -G rvm circleci

rvm version
rvm install ruby-2.6.5
rvm --default use ruby-2.6.5

ruby --version
sudo apt install gcc g++ make
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update
sudo apt install yarn nodejs

node --version
yarn --version
gem update --system
echo "gem: --no-document" >> ~/.gemrc
gem -v

gem install rails -v 6.0.2.1

rails --version

sudo apt install postgresql postgresql-contrib libpq-dev -y

systemctl start postgresql
systemctl enable postgresql

read username

sudo -i -u postgres psql
create role hakase_dev with createdb login password 'hakasepass';
