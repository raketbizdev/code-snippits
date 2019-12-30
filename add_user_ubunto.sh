  
#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Creating users

# create username
read username
sudo adduser ${username}

sudo usermod -aG sudo ${username}

cat /etc/passwd
grep '^${username}' /etc/passwd
