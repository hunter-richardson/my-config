    for i in (command ls -1 /etc/{opt/chrome,chromium}/policies/managed/policy.json)
      builtin printf '%s%s%s%s:\t%s%s%s%s\n' $bold $blue $i $normal $bold $red (command grep '\"IncognitoModeAvailability\"' $i | builtin string trim) $normal;
        or  builtin printf '\a'
    end;
and for i in (command ls -1 /usr/lib/firefox/distribution/policies.json)
      builtin printf '%s%s%s%s:\t%s%s%s%s\n' $bold $blue $i $normal $bold $red (command grep '\"DisablePrivateBrowsing\"' $i | builtin string trim) $normal;
        or  builtin printf '\a'
    end;
and builtin printf '%s%s/etc/hosts%s:\n' $bold $blue $normal;
and for i in google:forcesafesearch bing:strict duckduckgo:safe
      for j in (command grep (builtin printf '%s.com \#%s' (builtin printf '%s' $i | command cut -d: -f1) (builtin printf '%s' $i | command cut -d: -f2)) /etc/hosts)
        builtin test -n $j;
          and builtin printf '\t%s%s%s%s\n' $bold $red $j $normal;
          or  builtin printf '\a'
      end
    end;
and command google-chrome opendns.org/welcome 2>&-
