      for i in (command ls -1 /etc/{opt/chrome,chromium}/policies/managed/policy.json)
        builtin printf '%s%s%s%s: %s%s%s%s\n' $bold $blue $i $normal $bold $red (command grep '\"IncognitoModeAvailability\"' $i) $normal;
          or  builtin printf '\a'
      end;
  and for i in (command ls -1 /usr/lib/firefox/distribution/policies.json)
        builtin printf '%s%s%s%s: %s%s%s%s\n' $bold $blue $i $normal $bold $red (command grep '\"DisablePrivateBrowsing\"' $i) $normal;
          or  builtin printf '\a'
      end;
  and for i in forcesafesearch.google strict.bing safe.duckduckgo
        command grep (builtin printf '%s.com \%%s' (builtin printf '%s' $i | command cut -d. -f2) (builtin printf '%s' $i | command cut -d. -f1))
      end;
  and command google-chrome opendns.org/welcome
