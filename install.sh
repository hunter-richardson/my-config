#!/bin/bash
# Run /path/to/repo/rehome first!
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))
set GIT_DIR=$(dirname $MYCONFIG_DIR)

for i in $(cat $MYCONFIG_DIR/apt.key); do
  wget -v -O - $i | sudo apt-key add -
done
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6494C6D6997C215E
sudo echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
sudo echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' | sudo tee -a /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo wget -v -O /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v3.6/googler && sudo chmod +x /usr/local/bin/googler
for i in $(cat $MYCONFIG_DIR/dpkg.apt.sources)
  sudo add-apt-repository -y $i
done

sudo debconf-set-selections $MYCONFIG_DIR/apt.debconf
for "update"
    "autoremove"; do
  sudo apt $i -y
done
sudo apt install -y $(cat $MYCONFIG_DIR/dpkg.apt)
sudo apt purge -y $(cat $MYCONFIG_DIR/rdpkg.apt)
for "upgrade"
    "clean"; do
  sudo apt $i -y
done

sudo snap install $(cat $MYCONFIG_DIR/dpkg.snap)
sudo pip3 install -vvv $(cat $MYCONFIG_DIR/dpkg.pip3)

for i in $(cat $MYCONFIG_DIR/dpkg.git); do
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$(echo $i | cut -d'/' -f5 | cut -d'.' -f1)
done
