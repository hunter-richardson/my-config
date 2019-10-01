     command grep --color=always '\"IncognitoModeAvailability\"' /etc/{opt/chrome,chromium}/policies/managed/policy.json \
  && command grep --color=always '\"DisablePrivateBrowsing\"' /usr/{lib}/firefox/distribution/policies.json | command head -1 \
  && command google-chrome opendns.org/welcome
  || builtin printf '\a'
