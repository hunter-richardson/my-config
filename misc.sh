#!/bin/bash
# Run /path/to/repo/users.sh first!
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))

sudo tlp start
cd $MYCONFIG
sudo $(dirname $MYCONFIG_DIR)/matcha/Install

sudo xinput set-button-map 11 1 2 3 4 5 6 7 0 0

for i in "fish/functions"
         "fish/fundle/edc"
         "fish/fundle/oh-my-fish"
         "fish/fundle/tuvistavie"
         "skel/Pictures/screenshots"
         "skel/.config/git"; do
  sudo mkdir -p /etc/$i
done

for i in "etc/skel/.config/git/config"
         "etc/tmux.conf"
         "usr/local/sbin/adduser.local"
         "usr/share/gtksourceview-3.0/language-specs/fish.lang"
         "usr/share/nano/fish.nanorc"; do
  sudo ln -v $MYCONFIG_DIR/$i /$i
done

for i in "apt/apt.conf.d"
         "fish"
         "fish/functions"; do
  sudo ln -v $MYCONFIG_DIR/etc/$i/* /etc/$i/
done

for i in "apt-fast.conf"
         "bash.bashrc"
         "login.defs"
         "nanorc"
         "sudoers"; do
  sudo ln -fv $MYCONFIG_DIR/etc/$i /etc/$i
done

sudo fish --command="source /etc/fish/functions/fundle.fish; fundle install"
for i in "edc/bass"
         "oh-my-fish/plugin-*"
         "tuvistavie/oh-my-fish-core"; do
  sudo ln -v /root/.config/fish/fundle/$i/functions/*.fish /etc/fish/fundle/$(echo $i | cut -d'/' -f1)
done
