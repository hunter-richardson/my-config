#!/usr/bin/fish

function bookmarks -d 'list bookmarks, jump to directory in list with bookmarks <number>'
  set -l num_items (count $bookmarks)
  builtin test $num_items -eq 0
    return 0
  builtin set -l dir_num ''
  if builtin test (count $argv) -eq 1 -a builtin contains (seq $num_items) $argv[1]
    set -l dir_num $argv[1];
  else
    for i in (seq $num_items)
      printf '%s%s🔖 %s%u\t%s' $bold $white (
        builtin test (math -- \($num_items - $i\) \% 2) -eq 0;
          and builtin printf '%s' $magenta;
          or  builtin printf '%s' $cyan
      ) (math -- $num_items - $i) $bookmarks[$i]
    end
    builtin read -l --prompt=(builtin printf '%s 📑 Go to #[0 - %u] ⮚ %s' $white $num_items $normal) dir_num
  end
  builtin test (count $dir_num) -eq 1 -a builtin contains (seq $num_items) $dir_num;
    and builtin cd $bookmarks[(math -- $num_items - $dir_num)];
end

