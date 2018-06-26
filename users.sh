sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo usermod -a -G dev root
for u in $(members user); do
  set home_dir=$(getent passwd $i | cut -d':' -f6 | tail -c +2)
  sudo mkdir -p /$home_dir/.config/git
  for i in /path/to/repo/$home_dir/Pictures; do
    sudo ln -v $i /$home_dir/Pictures/$(basename "$i")
  done
  sudo ln -v /path/to/repo/$home_dir/.config/git/config /$home_dir/.config/git/config
  su $i --command="trackerd"
  su $i fish --command="source /etc/fish/functions/fundle.fish; fundle install"
done
sudo ln -v /usr/share/pixmaps/faces/lightning.jpg /home/hunter-adm/Pictures/profile.jpg 

