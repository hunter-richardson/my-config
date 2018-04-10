#!/bin/bash
# Run /path/to/repo/rehome first!
sudo passwd root
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))
set GIT_DIR=$(dirname $MYCONFIG_DIR)

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main"' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list

for i in $(cat $MYCONFIG_DIR/dpkg.apt.sources)
  sudo add-apt-repository -y $i
done

sudo apt-get update -y
sudo apt-get autoremove -y
sudo apt-get install -y $(cat $MYCONFIG_DIR/dpkg.apt)
sudo apt-get remove -y $(cat $MYCONFIG_DIR/rdpkg.apt)
sudo apt-get upgrade -y
sudo apt-get clean- y

sudo snap install $(cat $MYCONFIG_DIR/dpkg.snap)
sudo pip3 install $(cat $MYCONFIG_DIR/dpkg.pip3)

for i in $(cat $MYCONFIG_DIR/dpkg.git)
  set repo=$(echo $i | cut -d'/' -f2 | cut -d'.' -f1)
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$repo
  set repo=
done

sudo mkdir -p /etc/fish/functions /usr/share/icons/DMZhaloR24/cursors

sudo ln -v $MYCONFIG_DIR/etc/apt/apt.conf.d/* /etc/apt/apt.conf.d/
sudo ln -fv $MYCONFIG_DIR/etc/apt-fast.conf /etc/apt-fast.conf
sudo ln -fv $MYCONFIG_DIR/etc/lightdm/lightdm-unity-greeter.conf /etc/lightdm/lightdm-unity-greeter.conf
sudo ln -fv $MYCONFIG_DIR/etc/lightdm/lightdm.conf.d/* /etc/lightdm/lightdm.conf.d/
sudo ln -fv $MYCONFIG_DIR/etc/login.defs /etc/login.defs
sudo ln -fv $MYCONFIG_DIR/etc/nanorc /etc/nanorc
sudo ln -v $MYCONFIG_DIR/etc/tmux.conf /etc/tmux.conf
sudo ln -v $MYCONFIG_DIR/usr/local/sbin/adduser.local /usr/local/sbin/adduser.local
sudo ln -fv $MYCONFIG_DIR/etc/fish/* /etc/fish/
sudo ln -v $MYCONFIG_DIR/etc/fish/functions/* /etc/fish/functions/*
sudo ln -v $MYCONFIG_DIR/usr/share/gtksourceview-3.0/language-specs/fish.lang /usr/share/gtksourceview-3.0/language-specs/fish.lang
sudo ln -v $MYCONFIG_DIR/usr/share/nano/fish.nanorc /usr/share/nano/fish.nanorc
sudo ln -fv $MYCONFIG_DIR/etc/bash.bashrc /etc/bash.bashrc
sudo ln -rv $MYCONFIG_DIR/usr/share/icons/DMZhaloR24/* /usr/share/icons/DMZhaloR24/
sudo ln -rv $MYCONFIG_DIR/usr/share/icons/DMZhaloR24/cursors/* /usr/share/icons/DMZhaloR24/cursors/
sudo ln -fv $MYCONFIG_DIR/etc/sudoers /etc/sudoers

sudo groupadd dev
sudo groupadd user
sudo useradd -MU -c Hunter -G user,dev,sudo,ssh hunter
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo chown root:root /home/hunter*/.local/share/Trash

