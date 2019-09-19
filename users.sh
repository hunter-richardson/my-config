#!/bin/bash
# Run /path/to/repo/install.sh first!
sudo updatedb #refresh directory database
MYCONFIG_DIR=$(sudo locate -ei --limit=1 'my-config') #locate my-config repo
sudo groupadd dev && sudo groupadd user #add groups
sudo usermod -a -G user michelle
sudo usermod -a -G dev,root,ssh root
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo usermod -a -G user,dev,root,ssh hunter-adm
for u in $(members dev)
do
  [ -d $MYCONFIG_DIR/home/$i/Pictures ] sudo scp -v $MYCONFIG_DIR/home/$i/Pictures/* /$(commmand getent passwd | command cut -d':' -f6)/Pictures/ #copy user pictures
done
sudo mkdir /apartment
sudo mkfs.ext4 /dev/sdb /apartment
grep 'apartment' /etc/mtab | sudo tee -a /etc/fstab
for i in $(members user)
do
  sudo mkdir /apartment/$i
  sudo chown $i:$i /apartment/$i
  sudo chmod 744 /apartment/$i
done
