#!/usr/bin/fish

function update -d 'automate software updates from installed SPMs'
  builtin test ! (command members sudo | command grep (command whoami)) -a ! (command members root | command grep (command whoami));
    and echo 'You are not a sudoer!'
    and return 121
  command sudo apt update -y;
  and command sudo apt autoremove -y;
  and for i in (command sudo apt list --upgradable | command cut -d'/' -f1)
    command sudo apt upgrade -y $i
  end;
  and command sudo apt install -fy;
  and command sudo apt clean -y
  for i in (command sudo snap list | command sed -n '1!p' | command cut -d' ' -f1)
    builtin printf '%s /snap/%s\n' (command whereis $i | command cut -d' ' -f2) $i
    command sudo snap refresh $i
  end
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
