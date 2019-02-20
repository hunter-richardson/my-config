#!/bin/bash

sudo updatedb #refresh directory database
MYCONFIG_DIR=$(dirname $(command locate -eq 'my-config/.git' | command head -1)) #locate my-config repo

for i in $(command members user)
do
  case "$i" in 
    hunter-adm hunter michelle)
      home_dir=$(command getent passwd $i | command cut -d':' -f6 | command tail -c +2) #known users
      ;;
    *)
      home_dir='etc/skel' #unknown users
      ;;
  esac
  sudo --user=$i --command="dconf load / < $MYCONFIG_DIR/$home_dir/_settings.dconf" #load settings.dconf file
  builtin unset home_dir #free variables
done
