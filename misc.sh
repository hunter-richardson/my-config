#!/bin/bash
# Run /path/to/repo/users.sh first!
set MYCONFIG_DIR=$(dirname ${BASH_SOURCE[0]})

sudo tlp start
sudo $(dirname $MYCONFIG_DIR)/matcha/Install

sudo xinput set-button-map 11 1 2 3 4 5 6 7 0 0

for i in 'fish/conf.d/functions/fundle' 'skel/Pictures/screenshots'
do
  sudo mkdir -p /etc/$i
done

for i in 'etc/apt/apt.conf.d' 'etc/fish' 'etc/fish/conf.d' 'etc/fish/conf.d/completions' 'etc/fish/conf.d/functions' 'usr/local/sbin'
do
  sudo ln -v $MYCONFIG_DIR/$i/* /$i/
done

for i in 'apt-fast.conf' 'bash.bashrc' 'login.defs' 'nanorc' 'sudoers'
do
  sudo ln -fv $MYCONFIG_DIR/etc/$i /etc/
done
