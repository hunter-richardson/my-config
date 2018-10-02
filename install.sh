#!/bin/bash
# Run /path/to/repo/rehome first!
sudo updatedb
set MYCONFIG_DIR=$(command dirname $(locate -eq 'my-config/.git' | command head -1))
set GIT_DIR=$(command dirname $MYCONFIG_DIR)

for i in $(command cat $MYCONFIG_DIR/apt.key)
do
  command wget -v -O - $i | sudo apt-key add -
done

for i in $(command cat $MYCONFIG_DIR/custom-apt.key)
do
  builtin println '%s' $i | command read -d'_' server key
  sudo apt-key adv --keyserver $server --recv-keys $key
done

sudo ln -v $MYCONFIG_DIR/etc/apt/sources.list.d/external.list /etc/apt/sources.list.d/external.list
sudo wget -v -O /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v3.6/googler
sudo chmod +x /usr/local/bin/googler

for i in $(command cat $MYCONFIG_DIR/dpkg.apt.sources)
do
  sudo add-apt-repository -y $i
done

sudo debconf-set-selections $MYCONFIG_DIR/apt.debconf

for "update"
    "autoremove"
do
  sudo apt $i -y
done

sudo apt install -y $(command cat $MYCONFIG_DIR/dpkg.apt)
sudo apt purge -y $(command cat $MYCONFIG_DIR/rdpkg.apt)

for "upgrade"
    "clean"
do
  sudo apt $i -y
done

sudo snap install $(command cat $MYCONFIG_DIR/dpkg.snap)
sudo pip3 install -vvv $(command cat $MYCONFIG_DIR/dpkg.pip3)

for i in $(cat $MYCONFIG_DIR/dpkg.git)
do
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$(echo $i | cut -d'/' -f5 | cut -d'.' -f1)
done
