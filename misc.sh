#!/bin/bash
# Run /path/to/repo/users.sh first!
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))

cd $(dirname $MYCONFIG_DIR)/terminal-slack
sudo npm install
cd $MYCONFIG
sudo $(dirname $MYCONFIG_DIR)/matcha/.Install

sudo apt-fast install -y lightdm unity-greeter

for i in "etc/skel/Pictures/screenshots"
         "etc/fish/functions"
         "etc/skel/.config/git"; do
  sudo mkdir -p /$i
done

for i in "etc/skel/.config/git/config"
         "etc/tmux.conf"
         "usr/local/sbin/adduser.local"
         "usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override"
         "usr/share/gtksourceview-3.0/language-specs/fish.lang"
         "usr/share/nano/fish.nanorc"; do
  sudo ln -v $MYCONFIG_DIR/$i /$i
done

for i in "apt/apt.conf.d"
         "fish/functions"; do
  sudo ln -v $MYCONFIG_DIR/etc/$i/* /etc/$i/
done

for i in "apt-fast.conf"
         "bash.bashrc"
         "lightdm/lightdm-unity-greeter.conf"
         "login.defs"
         "nanorc"
         "sudoers"; do
  sudo ln -fv $MYCONFIG_DIR/etc/$i /etc/$i
done

for i in "etc/fish"
         "etc/lightdm/lightdm.conf.d"; do
  sudo ln -fv $MYCONFIG_DIR/my-config/$i/* /$i/
done
