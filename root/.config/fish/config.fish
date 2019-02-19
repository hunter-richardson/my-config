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

builtin set --local new_fundle_plugin (builtin test ! -d /root/.config/fish/fundle)
builtin test $new_fundle_plugin;
  or for i in (fundle list | command grep -v https://github.com)
       builtin test $new_fundle_plugin;
         and builtin break;
         or  builtin set --local new_fundle_plugin (builtin test ! -d /root/.config/fish/fundle/$i)
     end

builtin test $new_fundle_plugin;
  and fundle install;
  and for i in (fundle list | grep -v https://github.com)
        builtin printf 'load plugin %s\n' $i | builtin string replace / :
        for f in functions completions
          test -d /root/.config/fish/fundle/$i/$f;
            and chmod a+x /root/.config/fish/fundle/$i/$f/*;
            and ln -v /root/.config/fish/fundle/$i/$f/* /etc/fish/$f/
        end
      end
