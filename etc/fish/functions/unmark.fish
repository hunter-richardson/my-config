#!/usr/bin/fish

function unmark -d 'remove argument from bookmarks'
  builtin test (builtin count $argv) -lt 1 -o ! -d $argv;
    and unmark (command pwd);
    and return 0
  for i in $argv
    builtin test (builtin contains $i $bookmarks);
      and set -e bookmarks[(builtin contains -i $i $bookmarks)];
      and printf '%s%sBookmark %s%s%s removed.%s\n' $bold $white $cyan $i $white $normal
  end
end

