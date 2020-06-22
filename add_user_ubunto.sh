  
#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Creating users
# run this
# wget https://raw.githubusercontent.com/raketbizdev/code-snippits/master/add_user_ubunto.sh; sudo chmod 755 add_user_ubunto.sh; ./add_user_ubunto.sh;
# create username
echo 'Enter Desired Username:'
read username
sudo adduser ${username}

sudo usermod -aG sudo ${username}

echo 'Add Firewall'
ufw app list
ufw allow OpenSSH
ufw enable
ufw status



cat /etc/passwd
grep '^${username}' /etc/passwd

echo 'restarting ssh'
sudo systemctl restart ssh

groups ${username}

sudo mkdir /home/${username}/.ssh
sudo touch /home/${username}/.ssh/authorized_keys

