#!/bin/bash
# Run /path/to/repo/rehome first!
sudo updatedb
set MYCONFIG_DIR=$(dirname $(locate -eq 'my-config/.git' | head -1))
set GIT_DIR=$(dirname $MYCONFIG_DIR)

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  && sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main"' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6494C6D6997C215E
wget -nv -O - https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add - <
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' | sudo tee -a /etc/apt/sources.list.d/home:manuelschneid3r.list"
sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v3.6/googler && sudo chmod +x /usr/local/bin/googler
for i in $(cat $MYCONFIG_DIR/dpkg.apt.sources)
  sudo add-apt-repository -y ppa:$i
done

for i in "update -y"
         "autoremove -y"
         "install -y $(cat $MYCONFIG_DIR/dpkg.apt)"
         "remove -y $(cat $MYCONFIG_DIR/rdpkg.apt)"
         "upgrade -y"
         "clean- y"; do
  sudo apt-get $i
done

sudo snap install $(cat $MYCONFIG_DIR/dpkg.snap)
sudo pip3 install --require-hashes $(cat $MYCONFIG_DIR/dpkg.pip3)

for i in $(cat $MYCONFIG_DIR/dpkg.git)
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$(echo $i | cut -d'/' -f5 | cut -d'.' -f1)
done
cd $GIT_DIR/terminal-slack
  && sudo npm install