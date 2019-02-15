#!/usr/bin/fish

fundle plugin 'edc/bass'
fundle plugin 'decors/fish-colored-man'
fundle plugin 'decors/fish-source-highlight'
fundle plugin 'hunter-richardson/fish-humanize-duration'
fundle plugin 'hunter-richardson/done'
fundle plugin 'laughedelic/pisces'
fundle plugin 'oh-my-fish/plugin-await'
fundle plugin 'oh-my-fish/plugin-balias'
fundle plugin 'oh-my-fish/plugin-errno'
fundle plugin 'oh-my-fish/plugin-grc'
fundle plugin 'oh-my-fish/plugin-sublime'
fundle plugin 'oh-my-fish/plugin-thefuck'
fundle plugin 'oh-my-fish/plugin-xdg'
fundle plugin 'tuvistavie/oh-my-fish-core'
fundle init

if builtin test ! -d /root/.config/fish/fundle
  fundle install
  for i in (fish list | grep -v https://github.com)
    builtin printf 'load plugin %s\n' $i | builtin string replace / :
    builtin test -d /root/.config/fish/fundle/$i/completions/*;
      and chmod a+x /root/.config/fish/fundle/$i/completions/*;
      and ln -v /root/.config/fish/fundle/$i/completions/* /etc/fish/completions/
    builtin test -d /root/.config/fish/fundle/$i/functions/*;
      and chmod a+x /root/.config/fish/fundle/$i/functions/*;
      and ln -v /root/.config/fish/fundle/$i/functions/* /etc/fish/functions/
  end
