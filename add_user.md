# Adding User to Ubunto 18.04

`ssh root@your_server_ip`

`adduser username`
`usermod -aG sudo username`
`ufw app list`
`ufw allow OpenSSH`
`ufw enable`
`ufw status`
`nano /etc/ssh/sshd_config`
```
PasswordAuthentication no
# PasswordAuthentication yes
```
`ssh-copy-id username@your_server_ip`
