#!/usr/bin/fish

if builtin test -f /root/.config/fish/conf.d/functions/fundle.fish
  builtin source /root/.config/fish/conf.d/functions/fundle.fish
  builtin test -f /root/.config/fish/conf.d/completions/fundle.fish;
    and builtin source /root/.config/fish/conf.d/completions/fundle.fish

  fundle plugin 'edc/bass'
  fundle plugin 'decors/fish-colored-man'
  fundle plugin 'decors/fish-source-highlight'
  fundle plugin 'hunter-richardson/fish-humanize-duration'
  fundle plugin 'hunter-richardson/done'
  fundle plugin 'laughedelic/brew-completions'
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
    or for i in (fundle list --short)
         builtin test $new_fundle_plugin;
           and builtin break;
           or  builtin set --local new_fundle_plugin (builtin test ! -d /root/.config/fish/fundle/$i)
       end

  builtin test $new_fundle_plugin;
    and fundle install;
    and for i in (fundle list --short)
          builtin printf 'load plugin %s\n' $i | builtin string replace / :
          for f in functions completions
            builitn test -d /root/.config/fish/fundle/$i/$f;
              and command chmod a+x /root/.config/fish/fundle/$i/$f/*;
              and command ln -v /root/.config/fish/fundle/$i/$f/* /etc/fish/conf.d/$f/
          end
        end
end
