#!/bin/bash
# Run /path/to/repo/rehome first!
sudo updatedb #update directory database
MYCONFIG_DIR=$(sudo locate -ei --limit=1 'my-config') #locate my-config repo
GIT_DIR=$(command dirname $MYCONFIG_DIR) #dir up from my-config repo

for i in $(cat $MYCONFIG_DIR/custom-apt.key)
do
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $i #add manual apt keys
done

for i in $(command cat $MYCONFIG_DIR/apt.key)
do
  command curl -v $i | sudo apt-key add - #add linked apt keys
done

for i in $(command cat $MYCONFIG_DIR/dpkg.apt.sources)
do
  sudo add-apt-repository -y $i #add apt repositories
done

sudo ln -v $MYCONFIG_DIR/etc/apt/sources.list.d/external.list /etc/apt/sources.list.d/ #add manual apt repositories

sudo debconf-set-selections $MYCONFIG_DIR/apt.debconf #select apt GUI options

for 'update' 'autoremove'
do
  sudo apt $i -y #update apt and autoremove unused packages
done

sudo apt install -y $(command cat $MYCONFIG_DIR/dpkg.apt) #add apt packages
sudo apt purge -y $(command cat $MYCONFIG_DIR/rdpkg.apt) #remove apt packages

for 'upgrade' 'clean'
do
  sudo apt $i -y #upgrade and clean apt
done

sudo snap install $(command cat $MYCONFIG_DIR/dpkg.snap) #install snaps

command sh -c "$(sudo curl -fLSs https://raw.githubusercontent.com/Linuxbrew/install/master/install)" #download linuxbrew
builtin eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv) #setup linuxbrew
builtin printf "builtin eval \$($(brew --prefix)/bin/brew shellenv)" | sudo tee -a /etc/bash.bashrc #autosetup linuxbrew
sudo brew install -v $(command cat $MYCONFIG_DIR/dpkg.brew) #install brews

for i in $(cat $MYCONFIG_DIR/dpkg.raw)
do
  sudo curl -v -o /usr/local/bin/$(builtin printf '%s' $i | command grep -oE '[^//]+$') $i #download raw binary
  sudo chmod +x /usr/local/$(builtin printf '%s' $i | command grep -oE '[^//]+$') #make binary executable
done

lynx https://github.com/sharkdp/bat/releases/download/v0.10.0/bat-musl_0.10.0_amd64.deb #install bat

for i in $(cat $MYCONFIG_DIR/dpkg.git)
do
  sudo git clone --verbose --depth 1 $i $GIT_DIR/$(builtin printf '%s' $i | command grep -o '[^//]+$' | command cut -d'.' -f1) #clone repos
done
