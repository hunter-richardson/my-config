#!/bin/bash
# Run /path/to/repo/users.sh first!
sudo tlp start #initialize tlp
sudo updatedb #refresh directory database
MYCONFIG_DIR=$(sudo locate -ei --limit=1 'my-config') #locate my-config repo
sudo mkdir -p /etc/skel/Pictures/screenshots
for i in 'etc/apt/apt.conf.d' 'usr/local/sbin'
do
  sudo ln -v $MYCONFIG_DIR/$i/* /$i/ #link configuration files
done

for i in $MYCONFIG_DIR/*
do
  [ -f $i ] && ( sudo ln -fv $MYCONFIG_DIR/etc/$i /etc/ ) #link configuration files
done
