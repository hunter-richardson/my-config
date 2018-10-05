#!/usr/bin/fish

function update -d 'automate software updates from installed SPMs'
  function __update_apt
        sudo apt-fast update;
    and sudo apt-fast autoremove -y;
    and sudo apt-fast upgrade -y;
    and sudo apt-fast install -fy;
    and sudo apt-fast clean -y
  end
  function __update_git
    for i in /usr/share/git-repos/*
          sudo git -C $i config --get remote.origin.url;
      and sudo git -C $i pull
    end
  end
  function __update_pip
    for i in (command sudo pip3 list --format=freeze | cut -d= -f1)
      builtin printf '%s\n' (command whereis $i | command cut -d' ' -f2);
        sudo pip3 install $i -U -vvv
    end
  end
  function __update_snap
    for i in (command sudo snap list | command sed -n '1!p' | command cut -d' ' -f1)
      builtin printf '%s\n' (command whereis $i | command cut -d' ' -f2);
        and sudo snap refresh $i
    end
  end
  function __update_raw
    sudo updatedb
    for i in (command cat (sudo locate -eqr '/my-config/dpkg.raw'))
      sudo srm -lvz /usr/local/bin/(builtin printf '%s' $i | command grep -oE '[^//]+$')
      sudo curl -v -o /usr/local/bin/(builtin printf '%s' $i | command grep -oE '[^//]+$') $i
      sudo chmod +x /usr/local/bin/(builtin printf '%s' $i | command grep -oE '[^//]+$')
    end
  end
  function __update_fundle
    sudo updatedb
    for i in (sudo ls -lp (sudo locate -eqr '/.config/fish/fundle$' | command grep -v /usr) | command grep /\$ | command awk '{print $3}' | command uniq)
      builtin test $i = root; and sudo -u root fish -c "fundle self-update"
      sudo -u $i fish -c "command find ~/.config/fish/fundle/*/* -maxdepth 0 | builtin string replace '~/.config/fish/fundle' 'https://github.com'"
      sudo -u $i fish -c "fundle clean; and fundle update"
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
        and __update_fundle;
        and __update_git;
        and __update_pip;
        and __update_snap
      case apt
        __update_apt
      case fundle user
        __update_fundle
      case git
        __update_git
      case raw
        __update_raw
      case pip pip3 python python3
        __update_pip
      case snap
        __update_snap
      case '*'
        builtin printf '\a\tUsage:  update [apt | fundle user | git | raw | pip pip3 python python3 | snap | all]\n\tupdate all =:= update apt fundle git pip snap\n\tDefault:  update apt git pip snap'
    end
  end
  functions -e __update_apt
  functions -e __update_git
  functions -e __update_pip
  functions -e __update_snap
  functions -e __update_fundle
end
