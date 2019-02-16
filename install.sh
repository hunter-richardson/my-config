#!/bin/bash
# Run /path/to/repo/rehome first!
sudo updatedb
set MYCONFIG_DIR=$(sudo locate -ei --limit=1 'my-config')
set GIT_DIR=$(command dirname $MYCONFIG_DIR)

for i in $(cat $MYCONFIG_DIR/custom-apt.key)
do
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $i
done

for i in $(command cat $MYCONFIG_DIR/apt.key)
do
  command wget -v -O - $i | sudo apt-key add -
done

for i in $(command cat $MYCONFIG_DIR/apt.key)
do
  curl -v $i | sudo apt-key add -
done

for i in $(command cat $MYCONFIG_DIR/dpkg.apt.sources)
do
  sudo add-apt-repository -y $i
done

sudo ln -v $MYCONFIG_DIR/etc/apt/sources.list.d/external.list /etc/apt/sources.list.d/

sudo debconf-set-selections $MYCONFIG_DIR/apt.debconf

for 'update' 'autoremove'
do
  sudo apt $i -y
done

sudo apt install -y $(command cat $MYCONFIG_DIR/dpkg.apt)
sudo apt purge -y $(command cat $MYCONFIG_DIR/rdpkg.apt)

for 'upgrade' 'clean'
do
  sudo apt $i -y
done

command sh -c "$(sudo curl -fLSs https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
builtin eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
builtin printf "builtin eval \$($(brew --prefix)/bin/brew shellenv)" | sudo tee -a /etc/bash.bashrc
sudo brew install -v $(command cat $MYCONFIG_DIR/dpkg.brew)
sudo snap install $(command cat $MYCONFIG_DIR/dpkg.snap)

for i in $(cat $MYCONFIG_DIR/dpkg.raw)
do
  sudo curl -v -o /usr/local/bin/$(printf '%s' $i | grep -oE '[^//]+$') $i
  sudo chmod +x /usr/local/$(printf '%s' $i | grep -oE '[^//]+$')
done

lynx https://github.com/sharkdp/bat/releases/download/v0.10.0/bat-musl_0.10.0_amd64.deb

for i in $(cat $MYCONFIG_DIR/dpkg.git)
do
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$(printf '%s' $i | grep -o '[^//]+$' | command cut -d'.' -f1)
done
