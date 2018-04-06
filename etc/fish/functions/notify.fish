#!/usr/bin/fish

#function notify -d 'beep when the given or most recent command completes'
#  builtin set -q $argv; and eval $argv
#  builtin set -l $proc (builtin jobs -l -p)
#  builtin test -z $proc; and builtin return 0;
#  function _notify_proc_$proc -p $proc -V proc
#    builtin echo -n \a
#    functions -e _notify_proc_$proc
#  end
#end
