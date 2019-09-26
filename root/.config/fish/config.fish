#!/usr/bin/fish

builtin source /root/.config/fish/conf.d/functions/fundle.fish
builtin source /root/.config/fish/conf.d/completions/fundle.fish
for i in (command grep -Ev '^#' /root/.config/fish/fundle.plugins | command shuf)
  fundle plugin $i;
    and builtin printf 'load plugin %s\n' (builtin string replace / : $i)
end;
  and fundle init
