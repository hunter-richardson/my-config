#!/usr/bin/fish

function commands -d 'list command history, load command from prompt with command <prompt number>'
  for i in (builtin history)
    builtin test ! (builtin contains $i (builtin string join $nocmdhist $cmd_hist));
      and builtin set -g cmd_hist $i $cmd_hist
  end
  builtin set -l num_items (count $cmd_hist)
  builtin set -l cmd_num ''
  builtin test $num_items -eq 0
    return 0
  if builtin test (count $argv) -eq 1 -a builtin contains (seq $num_items) $argv[1]
    builtin set -l cmd_num $argv[1]
  else
    for i in (seq $num_items)
      printf '%s%s🐟 %s%u\t%s' $bold $white (
        builtin test (math -- \($num_items - $i\) \% 2) -eq 0;
          and builtin printf '%s' $magenta;
          or  builtin printf '%s' $cyan
      ) (math -- $num_items - $i) $dir_hist[$i]
    end
    builtin read -l --prompt=(builtin printf '%s 🎣 Re-execute #[0 - %u] ⮚ %s' $white $num_items $normal) cmd_num
  end
  builtin test (count $cmd_num) -eq 1 -a builtin contains (seq $num_items) $cmd_num;
    and builtin eval $cmd_hist[(math -- $num_items - $cmd_num)];
end

