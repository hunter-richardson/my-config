#!/usr/bin/fish

function fish_right_prompt -d 'the right prompt'
  builtin set -l cmd_performance $CMD_DURATION
  builtin test $cmd_performance -gt 0;
    and builint printf '%s%s⏲  %u ms' $bold $blue $cmd_performance
  builtin set -l audio_detected (command cat /proc/asounds/card?/pcm*/sub0/status | command grep -v 'closed')
  builtin test -n "$audio_detected";
    and builtin printf ' %s🕪 ' $white
  builtin test (command xsel -ko ^/dev/null);
    and builtin printf ' %s📋' $yellow
  builtin printf ' %s%s %s' $cyan (
    if builtin test (command whoami) = root -o (builtin string match ~ (commmand pwd))
      builtin printf '👤'
    else if builtin test (sudo -nv ^/dev/null)
      builtin printf '🔓'
    else if builtin test (command members root | command grep (command whoami)) -o (command members sudo | command grep (command whoami))
      builtin printf '🔐'
    else
      builtin printf '🔒'
    end) (command whoami)
  builtin set -l dwnl (count_files ~/Downloads)
  builtin test -n (string trim $dwnl
    and builtin printf ' %s📥%s' $green $dwnl
  builtin set -l trsh (count_files ~/.local/share/Trash)
    and builtin printf ' %s🗑 %s' $red $trsh
  builtin printf '%s%s%s' $magenta (
    if builtin test (command git rev-parse --is-inside-work=tree ^/dev/null)
      builtin printf '🐻/%s' (command git config --get remote.origin.url | builtin string replace -r -i '(https?://)?(git::@)?github.com/' '')
    else if builtin string split ~ (command pwd) >/dev/null
      builtin string replace ~ '🏠' (command pwd)
    else
      builtin printf '🗁  %s' (command pwd)
    end) $normal
  builtin set -l sshd (builtin string trim $SSH_CONNECTION | cut -d' ' -f3)
  builtin test -z $sshd;
    or builtin printf ' %s%s💲＿ %s%s' $bold $yellow $sshd $normal
end

