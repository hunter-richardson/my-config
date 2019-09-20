#!/usr/bin/fish

builtin source /root/.config/fish/conf.d/{completions,functions}/fundle.fish
for i in (command grep -Ev '^#' /root/.config/fish/fundle.plugins)
  fundle plugin $i;
    and builtin printf 'load plugin %s\n' (builtin string replace / : $i)
end
