#!/usr/bin/fish

for i in (builtin set -g | command grep '__fundle.*_plugin' | command cut -d' ' -f1 | command shuf)
  builtin test -n "$i";
    and builtin set -e $i;
    or  builtin continue
end;
  and for i in (command find /root -type f -name fundle.fish | command shuf)
        builtin source $i;
          and builtin printf 'load GITHUB/danhper:fundle fundle %s\n' (command basename (command dirname $i))
      end;
  and for i in (command grep -Ev '^#' /root/.config/fish/fundle.plugins | command shuf)
        fundle plugin $i
      end
fundle install | builtin string replace / : | builtin string replace 'installed in' '=>' | builtin string replace hunter-richardson \$ME;
  and fundle init;
  and fundle self-update;
  and fundle clean;
  and for i in (fundle list --short | command shuf)
        fundle update $i | builtin string replace / : | builtin string replace hunter-richardson \$ME
      end;
for i in (command ls -1 /root/.config/fish/fundle/**/{comple,func}tions/*.fish | command shuf)
  command ln -f $i /etc/fish/conf.d/(command basename (command dirname $i))/;
    and builtin printf 'global /etc/fish/conf.d/%s/%s => %s/%s %s fish %s\n' (command basename (command dirname $i)) (command basename $i | builtin string replace s '') (builtin printf '%s\n' $__fundle_plugin_urls | command grep (builtin printf '%s' $i | command cut -d/ -f6,7) | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper) (builtin printf '%s' $i | command cut -d/ -f6,7 | builtin string replace / : | builtin string replace hunter-richardson \$ME) (command basename $i .fish) (command basename (command dirname $i) | builtin string replace s '')
end
