      for i in (command ls -1 /etc/{opt/chrome,chromium}/policies/managed/policy.json)
        builtin printf '%s%s%s%s: %s%s%s%s' $bold $blue $i $normal $bold $red (command grep '\"IncognitoModeAvailability\"' $i) $normal;
          or  builtin printf '\a'
      end;
  and for i in (command ls -1 /usr/lib/firefox/distribution/policies.json)
        builtin printf '%s%s%s%s: %s%s%s%s' $bold $blue $i $normal $bold $red (command grep '\"DisablePrivateBrowsing\"' $i) $normal;
          or  builtin printf '\a'
      end;
  and command google-chrome opendns.org/welcome
