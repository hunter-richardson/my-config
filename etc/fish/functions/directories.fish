#!/usr/bin/fish

function directories -d 'List directory history, jump to directory in list with directories <number>; compare to (cdh)'
  for i in (builtin dirh)
    builtin test ! builtin contains $i (builtin string join (command pwd) $dir_hist);
      and builtin set -g dir_hist (
        builtin test $i = ~;
          and builtin printf '%s' $HOME;
          or  builtin printf '%s' $i) $dir_hist
  end
  builtin set -l num_items (math -- (count $dir_hist) - 1)
  builtin set -l dir_num
  builtin test $num_items -eq 0
    return 0
  if builtin test (count $argv) -eq 1 -a builtin contains (seq $num_items) $argv[1]
    builtin set -l dir_num $argv[1]
  else
    for i in (seq $num_items)
      printf '%s%s📁 %s%u\t%s' $bold $white (
        builtin test (math -- \($num_items - $i\) \% 2) -eq 0;
          and builtin printf '%s' $magenta;
          or  builtin printf '%s' $cyan
      ) (math -- $num_items - $i) $dir_hist[$i]
    end
    builtin read -l --prompt=(builtin printf '%s 📂 Go to #[0 - %u] ⮚ %s' $white $num_items $normal) dir_num
  end
  builtin test (count $dir_num) -eq 1 -a builtin contains (seq $num_items) $dir_num;
    and builtin cd $dir_hist[(math -- $num_items - $dir_num)];
end
