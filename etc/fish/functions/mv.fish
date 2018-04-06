#!/usr/bin/fish

function mv -d 'securely move directories and files across the system'
  builtin set argv (builtin string match -r '-[\/-._A-Za-z0-9\*]+ ' $argv)
  builtin test (builtin count $argv) -ne 2;
    and builtin echo 'Insufficient input!';
    and return 121
  builtin test ! -r $argv1[1];
    and builtin echo 'Source unreadable!';
    and return 121
  builtin test -e $argv[2] -a (builtin test -d $argv[2]; and builtin test ! -x $argv[2]; or builtin test ! -w $argv[2]);
    and builtin echo 'Destination unwriteable!';
    and return 121
  if builtin test -d $argv[1]
    builtin test -e $argv[2];
      or command mkdir -pv $argv[2] ^/dev/null
    command scp -rv $argvp[1] $argv[2];
      and command srm -lrvz $argv[1]
  else
    command scp -v $argv[1] $argv[2];
      and command srm -lvz $argv[1]
  end
end
