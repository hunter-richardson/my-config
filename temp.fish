wget https://archive-media-1.nyafuu.org/wg/image/1367/80/1367804719146.jpg /home/hunter-adm/Pictures/wallpaper.png
wget https://archive-media-1.nyafuu.org/wg/image/1376/39/1376399598980.jpg /home/hunter/Pictures/wallpaper.png
gsettings set org.gnome.desktop.background picutre-uri file:///home/hunter/Pictures/wallpaper.png

sudo add-apt-repository ppa:noobslab/themes
sudo apt update; and sudo apt install dark-aurora

wget https://gnome-look.org/p/99745 ~/Downloads/
dtrx ~/Downloads/163336-DMZhaloRP.tar.gz
sudo scp -v ~/Downloads/DMZhaloRP/DMZhaloR24 /usr/share/icons/
sudo ln -fs /usr/share/icons/DMZhaloR24/cursor.theme /etc/alternatives/x-cursor-theme
sudo srm -lvz ~/Downloads/*

mkdir ~/temp
wget https://raw.githubusercontent.com/oh-my-fish/theme-budspencer/master/fish_prompt.fish ~/temp/budspencer_prompt.fish

sudo git config --global color.ui always
sudo git config --global color.autocrlf input
sudo git config --global core.editor nano
sudo git config --global core.whitespace trailing-space,space-before-tab,cr-at-eol
sudo git config --global help.autocorrect 1