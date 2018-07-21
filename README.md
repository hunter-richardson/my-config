# my-config
This is the repository for my home computer's setup.
## A rundown of what's stored here.
- Installation instructions (i.e., [what you're reading now](README.md))
- [Software packages and repositories](#software-packages-and-repositories)
- [User files and configuration](#user-files-and-configuration)
- [Operating system and program configuration](#operating-system-and-program-configuration)
- [Shell configuration, aliases, and functions](#shell-configuration-aliases-and-functions)
- [User software/script initialization](#user-software-script-initialization)
- [Themes](#themes)
- [One-time execution for setup](#one-time-execution-for-setup)
- [Manual installation of extensions](#manual-installation-of-extensions)
- [Miscellaneous configuration](#miscellaneous-configuration)
---
## But first
I like having my non-root userspace (i.e., `/home/*`) mounted onto a separate disk. So far, [Ubuntu](https://ubuntu.com) has labeled this disk `/dev/sdb`. Getting `/home` mounted is a pain, but seeing as I've had to do it a few times, I think I've got it down. The script [`source /path/to/repo/rehome`](rehome) will perform this action. Since it involves wiping the files in `/home`, it will be easier to run in an `Alt F2` shell as root. Run this only once per installation.
---
## Second,
The default `root` password is NULL, which is dangerous. Modify it ASAP:
```shell
sudo passwd root
sudo updatedb
```
### Software packages and repositories
- [Ubuntu](https://ubuntu.com) ships with its own `apt` [PPAs](https://launchpad.com/ubuntu/bionic) installed. The [apt.key](apt.key) file contains the authentication keys to external apt sources (shown below), and the [dpkg.apt.sources](dpkg.apt.sources) file contains a list of my custom PPA keys. To apply them:
```shell
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main"' | sudo tee -a /etc/apt/sources.list.d/google-chrome.list
sudo sh -c 'echo "deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /"' | sudo tee -a /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v3.6/googler && sudo chmod +x /usr/local/bin/googler
for i in $(cat /path/to/repo/apt.key); do
  wget -v -O $i | sudo apt-key add -
done
for i in $(cat /path/to/repo/dpkg.apt.sources); do
  sudo add-apt-repository -y ppa:$i
done
```
- The [dpkg.apt](dpkg.apt) file contains the software packages I've installed via `apt`, [rdpkg.apt](rdpkg.apt) those I specifically want to remove, and [apt.debconf](apt.debconf) allowes for automated setup for certain packages. To apply them:
```shell
sudo debconf-set-selections /path/to/repo/apt.debconf
sudo apt-get update -y
sudo apt-get autoremove -y
sudo apt-get install -y $(cat /path/to/repo/dpkg.apt)
sudo apt-get purge -y $(cat /path/to/repo/rdpkg.apt)
sudo apt-get upgrade
sudo apt-get clean
```
- For packages [Ubuntu](https://ubuntu.com) doesn't offer in public, Bionic-secure PPAs, [Snaps](https://snapcraft.io) may do the trick. The [dpkg.snap](dpkg.snap) file contains the software packages I've installed via `snap`. To apply them:
```shell
sudo snap install $(cat /path/to/repo/dpkg.snap)
```
- For packages [Ubuntu](https://ubuntu.com) doesn't offer in PPAs or as Snaps, I looked elsewhere. The [dpkg.pip3](dpkg.pip3) file contains the two [Python](https://python.org) software packages I use. To apply them:
```shell
sudo pip3 install $(cat /path/to/repo/dpkg.pip3)
```
- Finally, for packages I simply could not find as prebuilt binaries, I installed with [`git`](https://git-scm.com), thus far from [Github](https://github.com).  The [dpkg.git](dpkg.git) file contains the `git` repositories I use, except [my-config](#). To apply them globally (i.e., in this repo's parent directory):
```shell
for i in $(cat /path/to/repo/dpkg.git)
  sudo git clone --verbose --depth 1 $i $(dirname /path/to/repo)/$(echo $i | cut -d'/' -f5 | cut -d'.' -f1)
done
cd $(dirname /path/to/repo/)/terminal-slack
  && sudo npm install
```
### User files and configuration
After installing software, use the system GUI to create the users -- the commands `adduser` and `useradd` don't seem to work. After each, allow the new user to authenticate, which creates his/her userspace directories. (Each user has a `$HOME/.config/git/config` file (e.g., [config](home/hunter/.config/git/config)) with  `git`-related configuration settings. Currently, they're identical.)
- Most likely, the administrative user `hunter-adm` was created before Ubuntu was installed. His files are stored in [hunter-adm](home/hunter-adm) and he belongs to the groups `user`, `dev`, `root`, and `ssh`.
```shell
sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo mkdir -p /home/hunter-adm/.config/git
sudo ln -v /path/to/repo/home/hunter-adm/.config/git/config /home/hunter-adm/.config/git/config
sudo ln -fv /path/to/repo/home/hunter-adm/Pictures/* /home/hunter-adm/Pictures/
done
```
- Next, create the regular user `hunter`. His files are stored in [hunter](home/hunter). He belongs to the groups `user`, `dev`, `sudo`, and `ssh`.
```shell
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo mkdir -p /home/hunter/.config/git
sudo ln -v /path/to/repo/home/hunter/.config/git/config /home/hunter/.config/git/config
sudo ln -fv /path/to/repo/home/hunter/Pictures/* /home/hunter/Pictures/
done
```
- The owner of all files not specific to any user is, of course, `root`. Its files are stored in [root](root).
```shell
sudo mkdir -p /root/.config/git
sudo usermod -a -G user,dev,root,ssh root
sudo ln -v /path/to/repo/root/.config/git/config /root/.config/git/config
```
### Operating system and program configuration
- [Ubuntu](https://ubuntu.com) ships with `apt` well-configured for the average user's needs -- but I'm not the average user. The [apt.conf.d](etc/apt/apt.conf.d) file contains my custom `apt` configuration. See the [apt.conf manual](https://linux.die.net/man/5/apt.conf) for more information. To apply them:
```shell
sudo ln -v /path/to/repo/etc/apt/apt.conf.d/* /etc/apt/apt.conf.d/
```

I also installed [`apt-fast`](https://github.com/ilikenwf/apt-fast) above. The [apt-fast.conf](etc/apt-fast.conf) file contains my configuration for it. To apply it:
```
sudo ln -fv /path/to/repo/etc/apt-fast.conf /etc/apt-fast.conf
```
- [Ubuntu](https://ubuntu.com) ships with `gdm3` as its default display manager. Currently, my favorite display manager is LightDM with Unity, which I also installed above. The [10_unity_greeter_background.gschema.override](usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override) and [lightdm-unity-greeter.conf](etc/lightdm/lightdm-unity-greeter.conf) files, and the [lightdm.conf.d](etc/lightdm/lightdm.conf.d) directory, contain my `lightdm` configuration. To apply them:
```shell
for i in "etc/lightdm/lightdm-unity-greeter.conf"
         "usr/share/glib-2.0/schemas/10_unity_greeter_background.gschema.override"; do
  sudo ln -v /path/to/repo/$i /$i
done
sudo ln -v /path/to/repo/etc/lightdm/lightdm.conf.d/* /etc/lightdm/lightdm.conf.d/
```
- The [login.defs](etc/login.defs) file contains setup flags related to user login, authentication, and permissions. See the [login.defs manual](http://man7.org/linux/man-pages/man5/login.defs.5.html) for more information. To apply it:
```shell
sudo ln -fv /path/to/repo/etc/login.defs /etc/login.defs
```
- Call me a heathen or whatever, but I use [`nano`](https://nano-editor.org) as my default text editor. The [nanorc](etc/nanorc) file contains its configuration. To apply it:
```shell
sudo ln -fv /path/to/repo/etc/nanorc /etc/nanorc
```
- To ensure each user has a consistent [`git`](https://git-scm.com) experience, I copied my `git` configuration to the [skel](etc/skel) directory, where it will populate to each created user. To apply it:
```shell
sudo mkdir -p /etc/skel/.config/git
sudo ln -v /path/to/repo/etc/skel/.config/git/config /etc/skel/.config/git/config
```
- The [sudoers](etc/sudoers) file contains additional setup flags related to user authentication and permissions. To apply it:
```shell
sudo ln -fv /path/to/repo/etc/sudoers /etc/sudoers
```
- `tmux` is a terminal multiplexer that sets up a status bar and allows windows to split into panes. The [tmux.conf](etc/tmux.conf) file contains my tmux configuration file. See the [tmux manual](https://man.openbsd.org/OpenBSD-current/man1/tmux.1) for more information. To apply it:
```shell
sudo ln -v /path/to/repo/etc/tmux.conf /etc/tmux.conf
```
- The [adduser.local](usr/local/sbin/adduser.local) file defines an executable that runs when a new user is created. See the [adduser manual](manpages.ubuntu.com/manpages/artful/man8/adduser) for more information. To apply it:
```shell
sudo ln -v /path/to/repo/usr/local/sbin/adduser.local /usr/local/sbin/adduser.local
```
- Disable the forward and back buttons on the mouse (if so equipped) with the following:
```shell
sudo xinput set-button-map 11 1 2 3 4 5 6 7 0 0
```
### Shell configuration, aliases, and functions
- [Ubuntu](https://ubuntu.com) ships with `bash` as its default shell. My favorite shell is [Fish](https://fishshell.com), which I also installed above, using [`fundle`](https://github.com/tuvistavie/fundle) to load some useful plugins. I've also written a few functions and aliases that are helpful for my shell in [fish](etc/fish) and its subdirectories. To apply them:
```shell
sudo mkdir -p /etc/fish/functions
for i in "fish"
         "fish/functions"; do
  sudo ln -rv /path/to/repo/etc/$i/* /etc/$i/
done
```
- The [fish.lang](usr/share/gtksourceview-3.0/language-specs/fish.lang) and [fish.nanorc](usr/share/nano/fish.nanorc) files contain configuration for syntax-highlighting of Fish scripts, in `gedit` and `nano`, respectively. To apply them:
```shell
sudo ln -v /path/to/repo/usr/share/gtksourceview-3.0/language-specs/fish.lang /usr/share/gtksourceview-3.0/language-specs/fish.lang
sudo ln -v /path/to/repo/usr/share/nano/fish.nanorc /usr/share/nano/fish.nano
```
- To use [Fish](https://fishshell.com) by default without going through the whole `cshs` trouble, I put a script at the bottom of the [bash.bashrc](etc/bash.bashrc) file which opens a `tmux` session into `fish`. (Make sure both `tmux` and `fish` work before using this!) To apply it:
```shell
sudo ln -fv /path/to/repo/etc/bash.bashrc /etc/bash.bashrc
```
### User software/script initialization
- After installing `apt` packages and configuring `fish`, initialize TLP and fundle by running the following commands in an `Alt F2` window:
```shell
sudo tlp start
sudo mkdir -p /etc/fish/fundle/edc /etc/fish/fundle/oh-my-fish /etc/fish/fundle/tuvistavie
sudo fish --command="source /etc/fish/functions/fundle.fish; fundle install"
for i in "edc/bass"
         "oh-my-fish/plugin-*"
         "tuvistavie/oh-my-fish-core"; do
  sudo ln -v /root/.config/fish/fundle/$i/functions/*.fish /etc/fish/$(echo $i | cut -d'/' -f1)
done
```
### Themes
[Ubuntu](https://ubuntu.com) ships with several themes installed. For cursors, the default is [DMZ-White](https://opendesktop.org/c/1460733789) is the default. I prefer [DMZHaloR32](https://opendesktop.org/c/1460734834). First download it (it should direct a hashed-url similar to `https://dl.opendesktop.org/api/files/downloadfile/id/1460734834/s/.../t/.../u//163336-DMZhaloRP.tar.gz`); to apply it:
```shell
sudo dtrx -nv /path/to/163336-DMZhaloRP.tar.gz
sudo mkdir -p /usr/share/icons/DMZhaloR32
sudo rsync -ADhorX /path/to/DMZhaloRP/DMZhaloR32/* /usr/share/icons/DMZhaloR32/
sudo ln -fs /usr/share/icons/DMZhaloR32/cursor.theme /etc/alternatives/x-cursor-theme
sudo srm -lrvz /path/to/DMZhaloRP /path/to/163336-DMZhaloRP.tar.gz
```
### One-time execution for setup
- Quick installation of all software can be attained by executing the [`source /path/to/repo/install.sh`](install.sh) script. It assumes the `/home` directory is on the right disc and the `root` password has been secured; otherwise it follows the instructions above. Run this only once per installation.
- Quick initialization of users' scripts and files can be attained by executing the [`source /path/to/repo/users.sh`](users.sh) script. It assumes the above script has been run and all users have been created, otherwise it follows the instructions above. Run this only once per installation.
- Quick setup of downloaded themes (i.e., those not available by SPMs) can be attained by executing the [`source /path/to/repo/themes.sh`](themes.sh) script. It assumes the theme(s) is/are in the user's `Downloads` directory; otherwise it follows the instructions above.
- Quick application of all configurations, settings, and files can be attained by executing the [`source /path/to/repo/misc.sh`](misc.sh) script. It assumes the above scripts have been run, otherwise it follows the instructions above. Run this only once per installation. **NOTE:  if anything breaks with this script, the machine will need to be purged _again_.**
### Manual installation of extensions 
Unfortunately and despite popular belief to the contrary, not _everything_ may be automated with CLI scripts, even in Linux.
- The following is a list of links to [Firefox extensions](https://addons.mozilla.org/firefox/extensions). Open each in Firefox and click the +Add to Firefox button to apply it. 
  - [Gnome Shell Integration](https://addons.mozilla.org/firefox/addon/gnome-shell-integration) is necessary to view and/or install [Gnome extensions](https://extensions.gnome.org) using Firefox... and since Gnome hasn't provided a command to do so yet, you must install it for each user.
  - User `hunter` uses [LastPass Password Manager](https://addons.mozilla.org/firefox/addon/lastpass-password-manager) in Firefox to view, utilize, and/or update passwords in the cloud.
- The following is a list of links to [Gnome extensions](https://extensions.gnome.org). For all users, open each in link Firefox or Chrome and and flip the switch to apply it, if desired; there is literally no way to automate this. Multiple attempts may be necessary for each extension to register with Gnome.
  - [Add Username to Top Panel](https://extensions.gnome.org/extension/1108) appends the user's full name to the topbar.
  - [Alternate Tab](https://extensions.gnome.org/extension/15) implements a window switcher that resembles MacOS. `Alt Tab` to activate it.
  - [Applications Menu](https://extensions.gnome.org/extension/6) implements a category-based applications menu, accessible from the topbar.
  - [Apt Update Indicator](https://extensions.gnome.org/extension/1139) monitors `apt` for software upgrades and autoremoval stats.
  - [Datetime Format](https://extensions.gnome.org/extension/1173) allows users to customize the datetime format on the status bar.
  - [Extensions](https://extensions.gnome.org/extension/1036) allows users to enable or disable Gnome extensions from the topbar.
  - [Extension Update Notifier](https://extensions.gnome.org/extension/1166) monitors installed Gnome extensions for updates.
  - [Mailnag](https://extensions.gnome.org/extension/886) monitors for email updates to specified addresses.
  - [No Title Bar](https://extensions.gnome.org/extension/1267) removes the title bar from the maximized windows.
  - [OpenWeather](https://extensions.gnome.org/extension/750) monitors for weather updates at specified locations.
  - [Places Status Indicator](https://extensions.gnome.org/extension/8) implements a navigation menu of the userspace.
  - [Suspend Button](https://extensions.gnome.org/extension/826) provides or removes buttons for system suspension and/or deactivation.
  - [Removable Drive Menu](https://extensions.gnome.org/extension/7) implements a navigation and management menu for removable drives.
  - [User Themes](https://extensions.gnome.org/extension/19) allows users to load Gnome-UI themes.
### Miscellaneous configuration
Many of the above Gnome extensions, as well as Gnome itself, have configurable variables. These are available to view and edit either by the `gnome-control-center`, `gnome-tweak-tool`, and `dconf-editor` GUI applications or by the `gsettings` and `dconf` commands. The [`source /path/to/repo/settings.sh`](settings.sh) script will populate as many such variables as are installed with what I think should be the default values. Since many of are user-personal, each user has a specific flavor of the key-values, detailed in his/her/its [_settings.dconf](home/hunter-adm/_settings.dconf) file.
- To load the variables individually as each user:
```shell
sudo --command="dconf load / < /path/to/repo/home/hunter-adm/_settings.dconf" --user=hunter-adm
sudo --command="dconf load / < /path/to/repo/home/hunter/_settings.dconf" --user=hunter
sudo --command="dconf load / < /path/to/repo/root/_settings.dconf" --user=root
sudo --command="dconf load / < /path/to/repo/etc/skel/_settings.dconf" --user=$(any account created later)
```
- Or the [`source /path/to/repo/settings.sh`](settings.sh) script is available to load the variables for each user automatically.
