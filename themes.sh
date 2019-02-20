# download https://opendesktop.org/c/1460734834
cd ~/Downloads #dir to downloads
command dtrx -nv ~/Downloads/163336-DMZhaloRP.tar.gz #extract theme
sudo mkdir -p /usr/share/icons/DMZhaloR32 #mkdir theme dir
sudo rsync -ADhorX ~/Downloads/163336-DMZhaloRP/DMZhaloRP/DMZhaloR32/* /usr/share/icons/DMZhaloR32/ #copy theme to new dir
sudo ln -fs /usr/share/icons/DMZhaloR24/cursor.theme /etc/alternatives/x-cursor-theme #link theme
sudo srm -lrvz ~/Downloads/163336-DMZhaloRP ~/Downloads/163336-DMZhaloRP.tar.gz #destroy download
