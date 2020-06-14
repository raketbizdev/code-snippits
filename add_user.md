# Adding User to Ubunto 18.04

`ssh root@your_server_ip`
Add User
`adduser username`

Enter Password
`passwd`

Add Sudo
`usermod -aG sudo username`
Add Firewall
```
ufw app list
ufw allow OpenSSH
ufw enable
ufw status
```
Change PasswordAuthentication from No to Yes

`nano /etc/ssh/sshd_config`
```
PasswordAuthentication no
# PasswordAuthentication yes
```

add sudoer to the user

`usermod -aG sudo newuser`

Restart server 
`sudo service ssh restart`

Copy ssh to the server

`ssh-copy-id username@your_server_ip`

then login if you are just using `id_rsa`

`ssh username@your_server_ip`

Bu if you name your ssh-kew differently you have to specify it pay calling the private-key

`ssh -i path/to/your/private-key username@your_server_ip`
