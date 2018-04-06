#!/usr/bin/fish

function rm -d 'securely delete directories and files'
  builtin set argv (builtin string replace -r '-[A-Za-z]+ ' ' ' $argv)
  builtin test (count $argv) -lt 0;
    and builtin echo 'No input!';
    and return 121
  for i in $argv
    builtin test ! -r $i -a -w $i;
      and builtin echo 'File ' $i ' unwriteable!';
      and return 121
  end
  for i in $argv
    builtin test -d $i;
      and srm -lrvz $i;
      or  srm -lvz $i
  end
end
