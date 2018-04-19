#!/usr/bin/fish

function update -d 'automate software updates from installed SPMs'
  function __update_apt
    command sudo apt-fast update;
      and command sudo apt-fast autoremove -y;
      and command sudo apt-fast upgrade -y;
      and command sudo apt-fast install -fy;
      and command sudo apt-fast clean -y
  end
  function __update_git
    for i in /usr/share/git-repos/*
      command sudo git -C $i config --get remote.origin.url;
        and command sudo git -C $i pull
    end
  end
  function __update_pip
    for i in (command sudo pip3 list --outdated --format=freeze | cut -d= -f1)
      builtin printf '%s\n' (command whereis $i | command cut -d' ' -f2);
        and command sudo pip3 install $i -Uv;
        or  command sudo pip3 uninstall $i -yv
    end
  end
  function __update_snap
    for i in (command sudo snap list | command sed -n '1!p' | command cut -d' ' -f1)
      builtin printf '%s\n' (command whereis $i | command cut -d' ' -f2);
        and command sudo snap refresh $i
    end
  end
  function __update_fundle
    command sudo updatedb
    for i in (command sudo ls -lp (command sudo locate -eqr '/.config/fish/fundle$' | command grep -v /usr) | command grep /\$ | command awk '{print $3}' | command uniq)
      builtin test $i = root; and command sudo -u root fish -c "fundle self-update"
      command sudo -u $i fish -c "command find ~/.config/fish/fundle/*/* -maxdepth 0 | builtin string replace '~/.config/fish/fundle' 'https://github.com'"
      command sudo -u $i fish -c "fundle clean; and fundle update"
    end
  end

  builtin test ! (command members sudo | command grep (command whoami)) -a ! (command members root | command grep (command whoami));
    and builtin echo 'You are not a sudoer!'
    and return 121
  builtin test (builtin count $argv) = 0;
    and builtin set -l SPMs apt git pip snap;
    or  builtin set -l SPMs (builtin printf '%s\n' $argv | command sort -diu)
  for s in $SPMs
    switch $s
      case all
        __update_apt;
          and __update_git;
          and __update_pip;
          and __update_snap
      case apt
        __update_apt
      case git
        __update_git
      case pip pip3 python python3
        __update_pip
      case snap
        __update_snap
      case user
        __update_fundle
      case '*'
        builtin printf '\a\tUsage:  update [apt | git | pip pip3 python python3 | snap | user | all]\n\tupdate all =:= update apt git pip snap user\n\tDefault:  update apt git pip snap'
    end
  end
  functions -e __update_apt
  functions -e __update_git
  functions -e __update_pip
  functions -e __update_snap
  functions -e __update_fundle
end
