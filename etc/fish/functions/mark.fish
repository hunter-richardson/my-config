#!/usr/bin/fish

function mark -d 'Add arguments to bookmarks.'
  builtin test (builtin count $argv) -lt 1 -o ! -d $argv;
    and mark (command pwd);
    and return 0
  for i in $argv
    builtin test ! (builtin contains $i $bookmarks);
      and set -g bookmarks $i $bookmarks;
      and printf '%s%s%s%s bookmarked.%s\n' $bold $cyan $i $white $normal
  end
end

