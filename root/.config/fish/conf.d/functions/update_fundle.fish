#!/usr/bin/fish

for i in (builtin set -g | command grep '__fundle.*_plugin' | command cut -d' ' -f1 | command shuf)
  builtin test -n "$i";
    and builtin set -e $i;
    or  builtin continue
end;
  and for i in (command find /root -type f -name fundle.fish | command shuf)
        builtin source $i;
          and builtin printf 'load %s%sGITHUB/%sdanhper:fundle%s fundle %s\n' $bold $blue $red $normal (command basename (command dirname $i))
      end;
  and for i in (command grep -Ev '^#' /root/.config/fish/fundle.plugins | command shuf)
        fundle plugin $i
      end
for i in (fundle install)
  builtin set -l iden (builtin printf '%s' $i | command cut -d' ' -f1);
    and builtin set -l path (builtin printf '%s' $i | command awk '{print $NF}');
    and builtin set -l src (builtin printf '%s\n' $__fundle_plugin_urls | command grep $iden | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper);
    and builtin printf '%s%s%s/%s%s%s => %s\n' $bold $blue $src $red (builtin printf '%s' $iden | builtin string replace / : | builtin string replace hunter-richardson \$ME) $normal $path
end;
  and fundle init;
  and fundle self-update | builtin string replace fundle (builtin printf '%s%sGITHUB/%sdanhper:fundle%s');
  and fundle clean;
  and for i in (fundle list --short | command shuf)
        builtin set -l src (builtin printf '%s\n' $__fundle_plugin_urls | command grep $i | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper);
          and for j in (fundle update $i)
                builtin printf 'Updating %s%s%s/%s%s%s\n' $bold $blue $src $red (builtin string replace / : $i | builtin string replace hunter-richardson \$ME) $normal
              end
      end;
for i in (command ls -1 /root/.config/fish/fundle/**/{comple,func}tions/*.fish | command shuf)
  builtin set -l iden (builtin printf '%s' $i | command cut -d/ -f6,7)
    and builtin set -l src (builtin printf '%s\n' $__fundle_plugin_urls | command grep $iden | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper)
    and command ln -f $i /etc/fish/conf.d/(command basename (command dirname $i))/;
    and builtin printf 'global /etc/fish/conf.d/%s/%s => %s%s%s/%s%s%s %s fish %s\n' (command basename (command dirname $i)) (command basename $i) $bold $blue $src $red (builtin string replace / : $iden | builtin string replace hunter-richardson \$ME) $normal (command basename $i .fish) (command basename (command dirname $i) | builtin string replace s '')
end
