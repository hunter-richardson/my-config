#!/bin/bash
# Run /path/to/repo/rehome first!
sudo updatedb #update directory database
MYCONFIG_DIR=$(sudo locate -ei --limit=1 'my-config') #locate my-config repo
GIT_DIR=$(command dirname $MYCONFIG_DIR) #dir up from my-config repo

for i in $(command grep -Ev '^#' $MYCONFIG_DIR/custom-apt.key)
do
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $i #add manual apt keys
done

for i in $(command grep -Ev '^#' $MYCONFIG_DIR/apt.key)
do
  command curl -v $i | sudo apt-key add - #add linked apt keys
done

for i in $(command grep -Ev '^#' $MYCONFIG_DIR/dpkg.apt.sources)
do
  sudo add-apt-repository -y $i #add apt repositories
done

sudo ln -v $MYCONFIG_DIR/etc/apt/sources.list.d/external.list /etc/apt/sources.list.d/ #add manual apt repositories

sudo debconf-set-selections $MYCONFIG_DIR/apt.debconf #select apt GUI options

for 'update' 'autoremove'
do
  sudo apt $i -y #update apt and autoremove unused packages
done

sudo apt install -y $(command grep -Ev '^#' $MYCONFIG_DIR/dpkg.apt) #add apt packages
sudo apt purge -y $(command grep -Ev '^#' $MYCONFIG_DIR/rdpkg.apt) #remove apt packages

for 'upgrade' 'clean'
do
  sudo apt $i -y #upgrade and clean apt
done

builtin printf '\nbuiltin eval $(thefuck --alias)\n' | sudo tee -a /etc/bash.bashrc #autosetup thefuck

for i in $(command grep -Ev '^#' $MYCONFIG_DIR/dpkg.snap)
do
  [ -d $i == 'slack' ] && sudo snap install $i --classic || sudo snap install $i #install snaps
done

builtin eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
for i in $(command grep -Ev '^#' $MYCONFIG_DIR/dpkg.brew)
do
  brew install -v $i
done

for i in $(command grep -Ev '^#' $MYCONFIG_DIR/dpkg.git)
do
  sudo git clone --verbose --depth 1 https://$i.git $GIT_DIR/$(builtin printf '%s' $i | command grep -o '[^//]+$') #clone repos
done

sudo ruby install bundle --verbose
for i in $(command grep -Ev '^#' $MYCONFIG_DIR/dpkg.gem)
do
  sudo bundle install $i --verbose
done
gem manpages --update-all
