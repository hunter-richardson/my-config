#!/bin/bash
# Run /path/to/repo/install.sh first!
sudo updatedb
set MYCONFIG_DIR=$(sudo locate -ei --limit=1 'my-config')
sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user michelle
sudo usermod -a -G dev,root,ssh root
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo usermod -a -G user,dev,root,ssh hunter-adm
for u in $(members dev)
do
  sudo ln -v $MYCONFIG_DIR/home/$i/Pictures/* /$home_dir/Pictures/
done
