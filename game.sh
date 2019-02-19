sudo adduser --disabled-password wine
sudo usermod -a -G wine-adm,wine-user hunter-adm
sudo usermod -a -G wine-user hunter
sudo usermod -a -G wine-user michelle

for i in $(command members wine-user)
do
  [ -z $(command cat ~$i/.profile | command grep i '^command xhost +local:wine$') ] && builtin printf 'command xhost +local:wine' | command tee -a ~$i/.profile
done

command wget https://fantasygrounds.com/filelibrary/FGWebInstall.exe | sudo --user='wine' --command='wine start - &'
