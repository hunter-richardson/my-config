#!/bin/bash
# Run /path/to/repo/install.sh
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
  for i in $MYCONFIG_DIR/$home_dir/Pictures; do
    sudo ln -v $i /$home_dir/Pictures/$(basename "$i")
  done
  sudo ln -v $MYCONFIG_DIR/$home_dir/.config/git/config /$home_dir/.config/git/config
  sudo $i --command="trackerd"
  sudo $i fish --command="source /etc/fish/functions/fundle.fish; fundle install"
done
sudo ln -v /usr/share/pixmaps/faces/lightning.jpg /home/hunter-adm/Pictures/profile.jpg
