for i in $(command ls -1 /etc/chromium/policies/managed/policies.json /etc/opt/chrome/policies/managed/policies.json)
  builtin printf '\e[1m;34m%s\e[0m: \e[1m;31m%s\e[0m\n' $i $(command grep '\"IncognitoModeAvailability\"' $i) || builtin printf '\a'
end && for i in $(command ls -1 /usr/lib/firefox/distribution/policies.json)
  builtin printf '\e[1m;34m%s\e[0m: \e[1m;31m%s\e[0m\n' $i $(command grep '\"DisablePrivateBrowsing\"' $i) || builtin printf '\a'
end && command google-chrome opendns.org/welcome
