#!/bin/bash
# Run /path/to/repo/users.sh first!
sudo tlp start
sudo updatedb
set MYCONFIG_DIR=$(sudo locate -ei --limit=1 'my-config')
sudo $(sudo locate -ei --limit=1 'matcha')/Install
sudo xinput set-button-map 11 1 2 3 4 5 6 7 0 0
sudo mkdir -p /etc/skel/Pictures/screenshots
for i in 'etc/apt/apt.conf.d' 'usr/local/sbin'
do
  sudo ln -v $MYCONFIG_DIR/$i/* /$i/
done

for i in $MYCONFIG_DIR/*
do
  [ -f $i ] && ( sudo ln -fv $MYCONFIG_DIR/etc/$i /etc/ )
done
