# download https://opendesktop.org/c/1460734834
cd ~/Downloads
sudo dtrx -nv ~/Downloads/163336-DMZhaloRP.tar.gz
sudo mkdir -p /usr/share/icons/DMZhaloR32
sudo rsync -ADhorX ~/Downloads/163336-DMZhaloRP/DMZhaloRP/DMZhaloR32/* /usr/share/icons/DMZhaloR32/
sudo ln -fs /usr/share/icons/DMZhaloR24/cursor.theme /etc/alternatives/x-cursor-theme
sudo srm -lrvz ~/Downloads/163336-DMZhaloRP ~/Downloads/163336-DMZhaloRP.tar.gz
