sudo adduser --disabled-password wine
sudo usermod -a -G wine-adm,wine-user hunter-adm
sudo usermod -a -G wine-user hunter
sudo usermod -a -G wine-user michelle

for i in $(command members wine-user)
do
  home=$(command getent passwd $i | command cut -d':' -f6)
  [ -n "$home" -a ! $(command grep -i '^(command )?xhost \+local:wine' $home/.profile) ] && builtin printf 'command xhost +local:wine' | command tee -a $home/.profile
  builtin unset home
done

command wget https://fantasygrounds.com/filelibrary/FGWebInstall.exe | sudo --user='wine' --command='command wine start - &'
