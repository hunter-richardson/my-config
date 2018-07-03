#!/bin/bash
# Run /path/to/repo/install.sh first!
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))

sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo usermod -a -G dev root
for u in $(members dev); do
  set home_dir=$(getent passwd $i | cut -d':' -f6 | tail -c +2)
  sudo mkdir -p /$home_dir/.config/git
  sudo ln -v $MYCONFIG_DIR/$home_dir/Pictures/* /$home_dir/Pictures/
  sudo ln -v $MYCONFIG_DIR/$home_dir/.config/git/config /$home_dir/.config/git/config
done
