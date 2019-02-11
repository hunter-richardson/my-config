#!/bin/bash
# Run /path/to/repo/install.sh first!
sudo updatedb
set MYCONFIG_DIR=$(dirname ${BASH_SOURCE[0]})

sudo groupadd dev
sudo groupadd user
sudo usermod -a -G dev,root,ssh root
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo usermod -a -G user,dev,root,ssh hunter-adm
for u in $(members dev)
do
  sudo ln -v $MYCONFIG_DIR/$(command getent passwd $i | command cut -d':' -f6 | command tail -c +2)/Pictures/* /$home_dir/Pictures/
done
