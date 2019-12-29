  
#!/bin/bash
# Author name: Ruel Nopal
# Company: Ruel Nopal - IT Consultant.
# url: www.ruelnopal.com
# Creating users

# create username
read username
sudo adduser ${username}

cat /etc/passwd
grep '^${username}' /etc/passwd
