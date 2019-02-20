sudo adduser --disabled-password wine #add user wine
sudo usermod -a -G wine-adm,wine-user hunter-adm #add wine-adm hunter-adm
sudo usermod -a -G wine-user hunter #add wine-user hunter
sudo usermod -a -G wine-user michelle #add wine-user michelle

for i in $(command members wine-user)
do
  home=$(command getent passwd $i | command cut -d':' -f6) #locate user homedir
  [ -n "$home" ] && [ ! $(command grep -i '^(command )?xhost \+local:wine' $home/.profile) ] && builtin printf 'command xhost +local:wine' | command tee -a $home/.profile #autosetup wine access
  builtin unset home #free variable
done

command xhost +local:wine #setup wine access
command curl -v https://fantasygrounds.com/filelibrary/FGWebInstall.exe | sudo --user=wine --command=$(bulitin printf 'command wine start /dev/stdout %s &' -) #download and install wine
