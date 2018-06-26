#!/bin/bash
# Run /path/to/repo/rehome first!
sudo passwd root
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))
set GIT_DIR=$(dirname $MYCONFIG_DIR)

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main"' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6494C6D6997C215E
for i in $(cat $MYCONFIG_DIR/dpkg.apt.sources); do
  sudo add-apt-repository -y $i
done

sudo apt-get update -y \
  && sudo apt-get autoremove -y \
  && sudo apt-get install -y $(cat $MYCONFIG_DIR/dpkg.apt) \
  && sudo apt-get remove -y $(cat $MYCONFIG_DIR/rdpkg.apt) \
  && sudo apt-get upgrade -y \
  && sudo apt-get clean- y

sudo snap install $(cat $MYCONFIG_DIR/dpkg.snap)
sudo pip3 install --require-hashes $(cat $MYCONFIG_DIR/dpkg.pip3)

for i in $(cat $MYCONFIG_DIR/dpkg.git); do
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$(echo $i | cut -d'/' -f5 | cut -d'.' -f1)
done
cd $GIT_DIR/terminal-slack \
  && sudo npm install

sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm
# create users:  hunter / "Hunter"
# allow new user(s) to authenticate before manipulating their home-directory
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo chown root:root /home/hunter*/.local/share/Trash
sudo ln -v /usr/share/pixmaps/faces/lightning.jpg /home/hunter-adm/Pictures/profile.jpg

for i in "hunter-adm/Pictures/wallpaper.png"
         "home/hunter/Pictures/wallpaper.jpg"
         "home/hunter/Pictures/profile.jpg"; do
  sudo ln -v $MYCONFIG_DIR/home/$i /home/$i
done

for i in $(members dev); do
  sudo mkdir -p /home/$i/.config/git
  sudo ln -v $MYCONFIG_DIR/home/$i/.config/git/config /home/$i/.config/git/config
done

sudo apt-fast install -y lightdm

for i in "etc/skel/Pictures/screenshots"
         "etc/fish/functions"
         "etc/skel/.config/git"
         "usr/share/icons/DMZhaloR24/cursors"; do
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
         "etc/lightdm/lightdm.conf.d"
         "usr/share/icons/DMZhaloR32"
         "usr/share/icons/DMZhaloR32/cursors"; do
  sudo ln -fv $MYCONFIG_DIR/my-config/$i/* /$i/
done

sudo fish --command="source /etc/fish/functions/fundle.fish; fundle install"
