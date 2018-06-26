#!/usr/bin/fish

alias albert 'command albert show'
alias copy 'command xset -b --input'
alias cp 'command scp -v'
alias cpdir 'command scp -rv'
alias datetime 'builtin test -n $argv[1]; and builtin set -l format $argv[1]; and builtin set -e argv[1]; or builtin set -l format "now"; command date "+%a %e %b %Y, %H%M %Z" -d $format'
alias dtrx 'command dtrx -v --one-entry inside'
alias egrep 'command egrep --color=auto'
alias fgrep 'command fgrep --color=auto'
alias fix 'fuck'
alias grep 'command grep --color=auto'
alias ls 'command ls -AhHl --file-type --time-style="+%a %e %b %Y, %H%M %Z" --color=auto'
alias mkdir 'command mkdir -pv'
alias nano 'command nano -AEiSU --tabsize=2 --softwrap'
alias now 'command date "+%H%M %Z" -d now'
alias opsystem "builtin printf '%s ' (command cat /etc/os-release | command head -2 | builtin string split '\"')[2]"
alias paste 'command xset -b --output'
alias parent 'test -z $argv[1]; and dirname (pwd); or dirname $argv[1]'
alias rm 'command srm -v'
alias rmdir 'command srm -rv'
alias share 'command pastebinit'
alias shrug 'builtin echo "¯\_(ツ)_/¯"'
alias today 'command date "+%a %e %b %Y" -d today'
alias tomorrow 'command date "+%a %e %b %Y" -d tomorrow'
alias yesterday 'command date "+%a %e %b %Y" -d yesterday'
alias @google 'command googler -n 9 -l en-us'
alias @amazon '@google -w amazon.com'
alias @alternatives '@google -w alternativeto.net'
alias @android-dev '@google -w developer.android.com'
alias @askubuntu '@google -w askubuntu.com'
alias @bbc '@google -w bbc.co.uk'
alias @britannica '@google -w britannica.com'
alias @cb '@google -w crunchbase.com'
alias @chrome '@google -w chrome.google.com'
alias @craigslist '@google -w craigslist.org'
alias @cross '@google -w lxr.free-electrons.com'
alias @cnn '@google -w cnn.com'
alias @cpp '@google -w en.cppreference.com'
alias @dictionary '@google -w dictionary.com/browse'
alias @distrowatch '@google -w distrowatch.com'
alias @define '@google -w en.wikipedia.org/wiki -w en.oxforddictionaries.com -w merriam-webster.com/dictionary -w dictionary.com/browse -w thefreedictionary.com -w yourdictionary.com -w urbandictionary.com'
alias @etsy '@google -w etsy.com'
alias @etymology '@google -w etymonline.com'
alias @fandango '@google -w fandango.com'
alias @firefox '@google -w addons.mozilla.org'
alias @forbes '@google -w forbes.com'
alias @freedictionary '@google -w thefreedictionary.com'
alias @github '@google -w github.com'
alias @gnome '@google -w gnome.org'
alias @gnu '@google -w gnu.org'
alias @gnupg '@google -w gnupg.org'
alias @had '@google -w hackaday.com'
alias @ieee '@google -w ieee.org'
alias @ietf '@google -w ietf.org'
alias @ietf-data '@google -w datatracker.ietf.org'
alias @ig '@google -w instagram.com'
alias @imdb '@google -w imdb.com'
alias @khan '@google -w khanacademy.org'
alias @linkedin '@google -w linkedin.com'
alias @linux '@google -w linux.com'
alias @linux-questions '@google -w linuxquestions.org'
alias @linus-questions-wiki '@google -w wiki.linuxquestions.org'
alias @lucky '@google -j'
alias @man '@google -w manpages.ubuntu.com'
alias @man7 '@google -w man7.org'
alias @merriam '@google -w merriam-webster.com/dictionary'
alias @music 'mpsyt set show_video false / '
alias @news 'google -N'
alias @ocw '@google -w ocw.mit.edu'
alias @omg '@google -w omgubuntu.co.uk'
alias @opensource '@google -w opensource.com'
alias @open-alts '@google -w osalt.com'
alias @osdev '@google -w wiki.osdev.org'
alias @oxford '@google -w en.oxforddictionaries.com'
alias @patent '@google -w patents.google.com'
alias @play '@google -w play.google.com'
alias @playonlinux '@google -w playonlinux.com'
alias @plus '@google -w plus.google.com'
alias @python '@google -w docs.python.org'
alias @quora '@google -w quora.com'
alias @reddit '@google -w reddit.com'
alias @sourceforge '@google -w sourceforge.net'
alias @stackoverflow '@google -w stackoverflow.com'
alias @steam '@google -w store.steampowered.com'
alias @thesaurus '@google -w thesaurus.com'
alias @ted '@google -w ted.com'
alias @tldp '@google -w tldp.org'
alias @torrenz '@google -w torrentz2.eu'
alias @tomatoes '@google -w rottentomatoes.com'
alias @ubuntuforums '@google -w ubuntuforums.org'
alias @ubuntupackages '@google -w packages.ubuntu.com'
alias @urbandictionary '@google -w urbandictionary.com'
alias @uwiki '@google -w wiki.ubuntu.com'
alias @wikipedia '@google -w en.wikipedia.org'
alias @wikiquote '@google -w en.wikiquote.org'
alias @weather '@google -w weather.com'
alias @wikia '@google -w wikia.com'
alias @xgoogle '@google -x'
alias @xkcd '@google -w xkcd.com'
alias @youtube 'mpsyt set show_video true / '
alias @yourdictionary '@google -w yourdictionary.com'
