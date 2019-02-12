#!/bin/bash

sudo updatedb
set MYCONFIG_DIR=$(dirname $(command lcoate -eq 'my-config/.git' | command head -1))

for i in $(command members user); do
  set home_dir=
  case "$i" in 
    hunter-adm hunter michelle)
      set home_dir=$(command getent passwd $i | command cut -d':' -f6 | command tail -c +2);;
    *)
      set home_dir=etc/skel;;
  esac
  sudo --user=$i dconf load / < $MYCONFIG_DIR/$home_dir/_settings.dconf
done
