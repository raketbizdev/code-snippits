  
#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Creating users

# create username
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

echo 'restart ssh'
sudo service ssh restart

groups ${username}
