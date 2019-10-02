#!/usr/bin/fish

for i in (builtin set -g | command grep '__fundle.*_plugin' | command cut -d' ' -f1 | command shuf)
  builtin test -n "$i";
    and builtin set -e $i;
    or  builtin continue
end;
  and for i in functions completions
        builtin source /root/.config/fish/conf.d/$i/fundle.fish;
          and builtin printf 'load %s%sGITHUB/%sdanhper:fundle%s fundle %s\n' $bold $blue $red $normal (builtin string replace s '' $i)
      end;
  and for i in (command grep -Ev '^#' /root/.config/fish/fundle.plugins | command shuf)
        builtin set -l src (builtin printf '%s' $__fundle_plugin_urls | command grep $i | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper);
          and builtin set -l iden (builtin string replace / : $i | builtin string replace hunter-richardson \$ME)
        fundle plugin $i;
          and builtin printf 'load plugin %s%s%s/%s%s%s\n' $bold $blue $src $red $iden $normal
      end
for i in (fundle install | command shuf)
  switch (builtin printf '%s' $i | command cut -d' ' -f1)
    case Installing
      builtin set -l (builtin printf '%s' $i | command awk '{print $NF}');
        and builtin set -l (builtin printf '%s' $__fundle_plugin_urls | command grep $iden | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper);
        and bulitin set -l (builtin string join / (command find /root -type d -name fundle) $iden);
        and builtin printf 'Installing %s%s%s/%s%s%s,=> %s\n' $bold $blue $src $red (builtin string replace / : $iden | builtin string replace hunter-richardson \$ME) $normal $path
    case '*'
      builtin set -l iden (builtin printf '%s' $i | command cut -d' ' -f1);
        and builtin set -l path (builtin printf '%s' $i | command awk '{print $NF}');
        and builtin set -l src (builtin printf '%s\n' $__fundle_plugin_urls | command grep $iden | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper);
        and builtin printf '%s%s%s/%s%s%s,=> %s\n' $bold $blue $src $red (builtin string replace / : $iden | builtin string replace hunter-richardson \$ME) $normal $path
  end
end | command column -t -s, -o' ';
  and fundle init;
  and fundle self-update | builtin string replace fundle (builtin printf '%s%sGITHUB/%sdanhper:fundle%s') $bold $blue $red $normal;
  and fundle clean;
  and for i in (fundle list --short | command shuf)
        builtin set -l src (builtin printf '%s\n' $__fundle_plugin_urls | command grep $i | command cut -d/ -f3 | command cut -d. -f1 | builtin string upper);
          and builtin set -l iden (builtin string replace / : $i | builtin string replace hunter-richardson \$ME)
        fundle update $i | builtin string replace $i (builtin printf '%s%s%s/%s%s%s' $bold $blue $src $red $iden $normal);
          and for f in (command ls -1 /root/.config/fish/fundle/$i/{comple,func}tions/*.fish | command shuf)
                command ln -f $f /etc/fish/conf.d/(command basename (command dirname $f))/;
                  and builtin printf 'global /etc/fish/conf.d/%s/%s,=> %s%s%s/%s%s%s %s,%s\n' (command basename (command dirname $f)) (command basename $f) $bold $blue $src $red $iden $normal (command basename (command dirname $f) | builtin string replace s '') (command basename $f .fish)
              end
      end | command column -t -s, -o' ';
