#!/bin/bash
# Run /path/to/repo/install.sh first!
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))

sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo usermod -a -G user,dev,root,ssh root
sudo usermod -a -G user,dev,sudo,ssh hunter
for u in $(members dev); do
  command set home_dir=$(command getent passwd $i | command cut -d':' -f6 | command tail -c +2)
  sudo mkdir -p /$home_dir/.config/git
  sudo ln -v $MYCONFIG_DIR/$home_dir/Pictures/* /$home_dir/Pictures/
  sudo ln -v $MYCONFIG_DIR/$home_dir/.config/git/config /$home_dir/.config/git/config
done
