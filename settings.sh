#!/bin/bash

sudo updatedb
set MYCONFIG_DIR=$(dirname $(lcoate -eq 'my-config/.git' | head -1))

for i in $(members user); do
  set home_dir=
  case "$i" in 
    root hunter-adm hunter)
      set home_dir=$(getent passwd $i | cut -d':' -f6 | tail -c +2)
      ;;
    *)
      set home_dir=etc/skel
      ;;
  esac
  dconf load / < $MYCONFIG_DIR/$home_dir/_settings.dconf
done
