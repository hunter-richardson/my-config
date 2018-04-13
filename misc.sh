#!/bin/bash
# Run /path/to/repo/rehome first!
sudo passwd root
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))
set GIT_DIR=$(dirname $MYCONFIG_DIR)

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main"' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6494C6D6997C215E
for i in $(cat $MYCONFIG_DIR/dpkg.apt.sources)
  sudo add-apt-repository -y $i
done

sudo apt-get update -y
  && sudo apt-get autoremove -y
  && sudo apt-get install -y $(cat $MYCONFIG_DIR/dpkg.apt)
  && sudo apt-get remove -y $(cat $MYCONFIG_DIR/rdpkg.apt)
  && sudo apt-get upgrade -y
  && sudo apt-get clean- y

sudo snap install $(cat $MYCONFIG_DIR/dpkg.snap)
sudo pip3 install --require-hashes $(cat $MYCONFIG_DIR/dpkg.pip3)

for i in $(cat $MYCONFIG_DIR/dpkg.git)
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$(echo $i | cut -d'/' -f2 | cut -d'.' -f1)
done

sudo mkdir -p /etc/skel/Pictures/screenshots /etc/fish/functions /etc/skel/.config/git /usr/share/icons/DMZhaloR24/cursors

sudo ln -v $MYCONFIG_DIR/etc/apt/apt.conf.d/* /etc/apt/apt.conf.d/
sudo ln -fv $MYCONFIG_DIR/etc/apt-fast.conf /etc/apt-fast.conf
sudo ln -fv $MYCONFIG_DIR/etc/bash.bashrc /etc/bash.bashrc
sudo ln -fv $MYCONFIG_DIR/etc/fish/* /etc/fish/
sudo ln -v $MYCONFIG_DIR/etc/fish/functions/* /etc/fish/functions/*
sudo ln -fv $MYCONFIG_DIR/etc/lightdm/lightdm-unity-greeter.conf /etc/lightdm/lightdm-unity-greeter.conf
sudo ln -fv $MYCONFIG_DIR/etc/lightdm/lightdm.conf.d/* /etc/lightdm/lightdm.conf.d/
sudo ln -fv $MYCONFIG_DIR/etc/login.defs /etc/login.defs
sudo ln -fv $MYCONFIG_DIR/etc/nanorc /etc/nanorc
sudo ln -v $MYCONFIG_DIR/etc/skel/.config/git/config /etc/skel/.config/git/config
sudo ln -v $MYCONFIG_DIR/etc/tmux.conf /etc/tmux.conf
sudo ln -v $MYCONFIG_DIR/usr/local/sbin/adduser.local /usr/local/sbin/adduser.local
sudo ln -v $MYCONFIG_DIR/usr/glib-2.0/schemas/10_unity_greeter_background.gschema.override /glib-2.0/schemas/10_unity_greeter_background.gschema.override
sudo ln -v $MYCONFIG_DIR/usr/share/gtksourceview-3.0/language-specs/fish.lang /usr/share/gtksourceview-3.0/language-specs/fish.lang
sudo ln -v $MYCONFIG_DIR/usr/share/nano/fish.nanorc /usr/share/nano/fish.nanorc
sudo ln -rv $MYCONFIG_DIR/usr/share/icons/DMZhaloR32/* /usr/share/icons/DMZhaloR32/
sudo ln -rv $MYCONFIG_DIR/usr/share/icons/DMZhaloR32/cursors/* /usr/share/icons/DMZhaloR32/cursors/

sudo fish --command="source /etc/fish/functions/fundle.fish; fundle install"

sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm

sudo ln -fv $MYCONFIG_DIR/etc/sudoers /etc/sudoers
sudo ln -v $MYCONFIG_DIR/home/hunter-adm/.config/git/config /home/hunter-adm/.config/git/config

sudo useradd -MU -c Hunter -G user,dev,sudo,ssh hunter
sudo chown root:root /home/hunter*/.local/share/Trash
sudo mkdir -p /home/hunter-adm/.config/git /home/hunter/.config/git
sudo ln -v $MYCONFIG_DIR/home/hunter-adm/Pictures/wallpaper.jpg /home/hunter-adm/Pictures/wallpaper.jpg
sudo ln -v /usr/share/pixmaps/faces/lightning.jpg /home/hunter-adm/Pictures/profile.jpg
sudo ln -v $MYCONFIG_DIR/home/hunter/Pictures/wallpaper.jpg /home/hunter/Pictures/wallpaper.jpg
sudo ln -v $MYCONFIG_DIR/home/hunter/Pictures/profile.jpg /home/hunter/Pictures/profile.jpg


