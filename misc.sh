#!/bin/bash
# Run /path/to/repo/rehome first!
#    Assume hunter-richardson/my-config is located in /usr/share/git-repos/my-config
set GIT_DIR=/usr/share/git-repos
set MYCONFIG_DIR=$GIT_DIR/my-config
sudo passwd root

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
suod sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main"' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list

for i in $(cat $MYCONFIG_DIR/dpkg.apt.sources)
  sudo add-apt-repository -y $i
end

sudo apt-get install -y $(cat $MYCONFIG_DIR/dpkg.apt)
sudo snap install $(cat $MYCONFIG_DIR/dpkg.snap)
sudo pip3 install $(cat $MYCONFIG_DIR/dpkg.pip3)

for i in $(cat $MYCONFIG_DIR/dpkg.git)
  set repo=$(echo $i | cut -d'/' -f2)
  sudo git clone --verbose --depth 1 https://github.com/$i $GIT_DIR/$repo
  set repo=
end

sudo mkdir -p /etc/fish/functions

sudo ln -v $MYCONFIG_DIR/etc/apt/apt.conf.d/* /etc/apt/apt.conf.d/
sudo ln -fv $MYCONFIG_DIR/etc/apt-fast.conf /etc/apt-fast.conf
sudo ln -v $MYCONFIG_DIR/etc/lightdm/lightdm-unity-greeter.conf /etc/lightdm/lightdm-unity-greeter.conf
sudo ln -v $MYCONFIG_DIR/etc/lightdm/lightdm.conf.d/* /etc/lightdm/lightdm.conf.d/
sudo ln -fv $MYCONFIG_DIR/etc/login.defs /etc/login.defs
sudo ln -fv $MYCONFIG_DIR/etc/nanorc /etc/nanorc
sudo ln -fv $MYCONFIG_DIR/etc/sudoers /etc/sudoers
sudo ln -v $MYCONFIG_DIR/etc/tmux.conf /etc/tmux.conf
sudo ln -v $MYCONFIG_DIR/usr/local/sbin/adduser.local /usr/local/sbin/adduser.local
sudo ln -v $MYCONFIG_DIR/etc/fish/* /etc/fish/
sudo ln -v $MYCONFIG_DIR/etc/fish/functions/* /etc/fish/functions/*
sudo ln -v $MYCONFIG_DIR/usr/share/gtksourceview-3.0/language-specs/fish.lang /usr/share/gtksourceview-3.0/language-specs/fish.lang
sudo ln -v $MYCONFIG_DIR/usr/share/nano/fish.nanorc /usr/share/nano/fish.nanorc
sudo ln -fv $MYCONFIG_DIR/etc/bash.bashrc /etc/bash.bashrc

sudo scp -rv $MYCONFIG_DIR/usr/share/icons/DMZhaloR24 /usr/share/icons/

sudo useradd -MU -c Hunter -G user,dev,sudo,ssh
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo chown root:root /home/hunter*/.local/share/Trash

# TODO: add gsettings commands