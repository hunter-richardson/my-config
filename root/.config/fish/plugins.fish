#!/usr/bin/fish

if builtin test -f /root/.config/fish/conf.d/functions/fundle.fish
  builtin source /root/.config/fish/conf.d/functions/fundle.fish
  builtin test -f /root/.config/fish/conf.d/completions/fundle.fish;
    and builtin source /root/.config/fish/conf.d/completions/fundle.fish
  for i in (builtin set -g | command cut -d' ' -f1 | command grep -E '^__fundle.*_plugin$')
    set -e $i
  end

  for i in decors/fish-colored-man decors/fish-source-highlight hunter-richardson/fish-bax hunter-richardson/fish-getopts hunter-richardson/fish-humanize-duration hunter-richardson/done laughedelic/brew-completions laughedelic/pisces oh-my-fish/plugin-await oh-my-fish/plugin-errno oh-my-fish/plugin-grc oh-my-fish/plugin-sublime oh-my-fish/plugin-thefuck oh-my-fish/plugin-xdg tuvistavie/fish-completion-helpers tuvistavie/oh-my-fish-core
    fundle plugin $i
  end
  fundle init

  builtin set --local new_fundle_plugin (builtin test ! -d (__fundle_plugins_dir))
  builtin test $new_fundle_plugin;
    or for i in (fundle list --short)
         builtin test $new_fundle_plugin;
           and builtin break;
           or  builtin set --local new_fundle_plugin (builtin test ! -d (__fundle_plugins_dir)/$i)
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
