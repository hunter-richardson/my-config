#!/bin/bash
# Run /path/to/repo/install.sh first!
sudo updatedb
set MYCONFIG_DIR=$(command dirname $(command locate -eq 'my-config/.git' | command head -1))

sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo usermod -a -G user,dev,root,ssh root
sudo usermod -a -G user,dev,sudo,ssh hunter
for u in $(members dev); do
  home_dir=$(command getent passwd $i | command cut -d':' -f6 | command tail -c +2)
  sudo mkdir -p /$home_dir/.config/git
  sudo ln -v $MYCONFIG_DIR/$home_dir/Pictures/* /$home_dir/Pictures/
  sudo ln -v $MYCONFIG_DIR/$home_dir/.config/git/config /$home_dir/.config/git/config
done
