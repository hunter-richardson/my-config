# download https://gnome-look.org/p/999745
sudo dtrx -nv ~/Downloads/163336-DMZhaloRP.tar.gz
sudo mkdir -p /usr/share/icons/DMZhaloR32
sudo rsync -ADhorX ~/Downloads/DMZhaloRP/DMZhaloR32/* /usr/share/icons/DMZhaloR32/
sudo ln -fs /usr/share/icons/DMZhaloR24/cursor.theme /etc/alternatives/x-cursor-theme
sudo srm -lrvz ~/Downloads/DMZhaloRP ~/Downloads/163336-DMZhaloRP.tar.gz
