      command grep --color=always '\"IncognitoModeAvailability\"' /etc/{opt/chrome,chromium}/policies/managed/policy.json;
  and command grep --color=always '\"DisablePrivateBrowsing\"' /usr/{lib}/firefox/distribution/policies.json | command head -1;
  and command google-chrome opendns.org/welcome
