# Configure your volume

To configure your volume, run the following commands on your Droplet.
```
ssh root@000.111.222.33
```
To format the volume, copy and paste the text below:
Format the volume with ext4 **Warning: This will erase all data on the volume. Only run this command on a volume with no existing data.**
```
$ sudo mkfs.ext4 -F /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01
```
To mount the volume, copy and paste the text below:
create a mount volume under /mnt
```
sudo mkdir -p /mnt/volume-nyc1-01
```
mount the volume
```
$ sudo mount -o discard,defaults /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01 
```
Change fstab so the volume will be mounted after a reboot
```
$ echo /dev/disk/by-id/scsi-0DO_Volume_volume-nyc1-01 /mnt/volume-nyc1-01 ext4 defaults,nofail,discard 0 0 | sudo tee -a /etc/fstab
```

The volume is now accessible at /mnt/volume-nyc1-01, and you are able to write files and store other data. This data will persist if you detach the volume, and will continue to be available when the volume is reattached to another Droplet. If you want you can customize the commands above, please refer to the following articles:
