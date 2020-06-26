  
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

echo 'Add public key to the authorized_keys:'
echo 'Enter public_key from your local machine:'
read pubkey
sudo cat >> /home/${username}/.ssh/authorized_keys <<EOL
  ${pubkey}
EOL
echo ${pubkey}
echo 'public_key added'
echo 'change user permision to ${username}'
sudo chown ${username}:${username} /home/${username}/.ssh/authorized_keys
echo ' everything is complet now login using the new user with the ssh default port 22'
echo 'deleting add_user_ubunto.sh'
echo 'if you like this script dont forget to spread the word and give a beer to this man.'
echo 'my paypal https://paypal.me/freelancerdad'
sudo rm add_user_ubunto.sh
