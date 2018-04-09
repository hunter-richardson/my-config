#!/usr/bin/fish

function update -d 'automate software updates from installed SPMs'
  builtin test ! (command members sudo | command grep (command whoami)) -a ! (command members root | command grep (command whoami));
    and echo 'You are not a sudoer!'
    and return 121
  command sudo apt update -y;
  and command sudo apt autoremove -y;
  and command sudo apt upgrade -y;
  and command sudo apt install -fy;
  and command sudo apt clean -y
  command sudo snap refresh $i
  for i in (command sudo pip3 list --outdated --format=legacy | cut -d' ' -f1)
    builtin echo $i;
      and command sudo pip3 install $i -U;
      or  command sudo pip3 uninstall $i
  end
  for i in (command ls /usr/share/git-repos)
    command sudo git -C /usr/share/git-repos/$i config --get remote.origin.url
    command sudo git -C /usr/share/git-repos/$i pull
  end
end
