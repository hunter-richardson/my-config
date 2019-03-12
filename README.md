# my-config [![CodeFactor](https://www.codefactor.io/repository/github/hunter-richardson/my-config/badge)](https://www.codefactor.io/repository/github/hunter-richardson/my-config)
This is the repository for my home computer's setup.
## A rundown of what's stored here.
- Installation instructions (i.e., [what you're reading now](README.md))
- [Software packages and repositories](#software-packages-and-repositories)
- [User files and configuration](#user-files-and-configuration)
- [Operating system and program configuration](#operating-system-and-program-configuration)
- [Shell configuration, aliases, and functions](#shell-configuration-aliases-and-functions)
- [Themes](#themes)
- [One-time execution for setup](#one-time-execution-for-setup)
- [Manual installation of extensions](#manual-installation-of-extensions)
- [Miscellaneous configuration](#miscellaneous-configuration)
- [Multiuser game installation](#multiuser-game-installation)

---
## But first
I like having my non-root userspace (i.e., `/home/*`) mounted onto a separate disk. So far, [Ubuntu](https://ubuntu.com) has labeled this disk `/dev/sdb`. Getting `/home` mounted is a pain, but seeing as I've had to do it a few times, I think I've got it down. The script [`source /path/to/repo/rehome.sh`](rehome.sh) will perform this action. Since it involves wiping the files in `/home`, it will be easier to run in an `Alt F2` shell as root. Run this only once per installation.

## Second,
The default `root` password is NULL, which is dangerous. Modify it ASAP:
```bash
sudo passwd root
sudo updatedb
```
### Software packages and repositories
- [Ubuntu](https://ubuntu.com) ships with its own `apt` [PPAs](https://launchpad.com/ubuntu/cosmic) installed. The [apt.key](apt.key) and [custom-apt.key](custom-apt.key) files contains authentication keys (the former linked, the latter unlinked); the [dpkg.apt.sources](dpkg.apt.sources) file contains a list of my custom PPA sources; and the [external.list](etc/apt/sources.list.d/external.list) file contains a list of my custom non-PPA sources. To apply them:
```bash
for i in $(grep -Ev '^#' /path/to/repo/custom-apt.key)
do
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $i
done
for i in $(grep -Ev '^#' /path/to/repo/apt.key)
do
  curl -v $i | sudo apt-key add -
done
for i in $(grep -Ev '^#' /path/to/repo/dpkg.apt.sources)
do
  sudo add-apt-repository -y $i
done
sudo ln -v /path/to/repo/etc/apt/sources.list.d/external.list /etc/apt/sources.list.d/
```
- The [dpkg.apt](dpkg.apt) file contains the software packages I've installed via `apt`, [rdpkg.apt](rdpkg.apt) those I specifically want to remove, and [apt.debconf](apt.debconf) allows for automated setup for certain packages. To apply them (assuming the previous keys and PPAs are loaded):
```bash
sudo debconf-set-selections /path/to/repo/apt.debconf
sudo apt-get update -y
sudo apt-get autoremove -y
sudo apt-get install -y $(grep -Ev '^#' /path/to/repo/dpkg.apt)
sudo apt-get purge -y $(grep -Ev '^#' /path/to/repo/rdpkg.apt)
sudo apt-get upgrade
sudo apt-get clean
sudo tlp start
```
- For packages [Ubuntu](https://ubuntu.com) doesn't offer in public, Cosmic-secure PPAs, [Snaps](https://snapcraft.io) may do the trick. The [dpkg.snap](dpkg.snap) file contains the software packages I've installed via `snap`. To apply them:
```bash
for i in $(grep -Ev '^#' /path/to/repo/dpkg.snap)
do
  [ $i == 'slack' ]
      && sudo snap install $i --classic
      || sudo snap install $i
done
```
- For packages [Ubuntu](https://ubuntu.com) doesn't offer in PPAs or Snaps, I looked elsewhere. The [dpkg.brew](dpkg.brew) file contains a single [Homebrew](https://linuxbrew.sh) formula I use. To apply them:
```bash
builtin eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
sudo brew install -v $(grep -Ev '^#' /path/to/repo/dpkg.brew)
```
- Some packages aren't even available on [Homebrew](https://linuxbrew.sh). The [dpkg.gem](dpkg.gem) file contains the [Ruby](https://rubygems.org) gems I use. To apply it:
```bash
for i in $(grep -Ev '^#' /path/to/repo/dpkg.gem)
do
  sudo gem install $i --verbose
done
gem manpages --update-all
```
- Finally, I installed my shell configuration.  The [dpkg.git](dpkg.git) file contains its `git` repository. To apply it globally (i.e., in this repo's parent directory):
```shell
for i in $(grep -Ev '^#' /path/to/repo/dpkg.git)
do
  sudo git clone --verbose --depth 1 https://$i.git $(dirname /path/to/repo)/$(echo $i | grep -oE '[^//]+$' | cut -d'.' -f1)
done
```
### User files and configuration
After installing software, use the system GUI to create the users -- the commands `adduser` and `useradd` don't seem to work. After each, allow the new user to authenticate, which creates his/her userspace directories.
- Most likely, the administrative user `hunter-adm` was created before Ubuntu was installed. His files are stored in [hunter-adm](home/hunter-adm) and he belongs to the groups `user`, `dev`, `root`, and `ssh`.
```bash
sudo groupadd dev
sudo groupadd user
sudo usermod -a -G user,dev,root,ssh hunter-adm
sudo scp -v /path/to/repo/home/hunter-adm/Pictures/* /home/hunter-adm/Pictures/
```
- Next, create the regular user `hunter`. His files are stored in [hunter](home/hunter). He belongs to the groups `user`, `dev`, `sudo`, and `ssh`.
```bash
sudo usermod -a -G user,dev,sudo,ssh hunter
sudo scp -v /path/to/repo/home/hunter/Pictures/* /home/hunter/Pictures/
```
- Next, create the regular user `michelle`. Her files are stored in [michelle](home/michelle). She belongs to the `user` group.
```bash
sudo usermod -a -G user michelle
sudo scp -v /path/to/repo/home/michelle/Pictures/* /home/michelle/Pictures/
```
- The owner of all files not specific to any user is, of course, `root`. Its files are stored in [root](root). It belongs to the groups `user`, `dev`, `root`, and `ssh`.
```bash
sudo usermod -a -G dev,root,ssh root
```
### Operating system and program configuration
- [Ubuntu](https://ubuntu.com) ships with `apt` well-configured for the average user's needs -- but I'm not the average user. The [apt.conf.d](etc/apt/apt.conf.d) file contains my custom `apt` configuration. See the [apt.conf manual](https://linux.die.net/man/5/apt.conf) for more information. To apply them:
```bash
sudo ln -v /path/to/repo/etc/apt/apt.conf.d/* /etc/apt/apt.conf.d/
```
I also installed [`apt-fast`](https://github.com/ilikenwf/apt-fast) above. The [apt-fast.conf](etc/apt-fast.conf) file contains my configuration for it. To apply it:
```bash
sudo ln -fv /path/to/repo/etc/apt-fast.conf /etc/
```
- The [login.defs](etc/login.defs) file contains setup flags related to user login, authentication, and permissions. See the [login.defs manual](http://man7.org/linux/man-pages/man5/login.defs.5.html) for more information. To apply it:
```bash
sudo ln -fv /path/to/repo/etc/login.defs /etc/login.defs
```
- I use [`nano`](https://nano-editor.org) as my default text editor. The [nanorc](etc/nanorc) file contains its configuration. To apply it:
```bash
sudo ln -fv /path/to/repo/etc/nanorc /etc/nanorc
```
- [`bat`](https://github.com/sharkdp/bat), installed previously, may use [bat/conf](etc/bat/conf) for its configuration. To apply it:
```bash
sudo ln -fv /path/to/repo/etc/bat/conf /etc/bat/
```
- The [sudoers](etc/sudoers) file contains additional setup flags related to user authentication and permissions. To apply it:
```bash
sudo ln -fv /path/to/repo/etc/sudoers /etc/sudoers
```
- The [adduser.local](usr/local/sbin/adduser.local) file defines an executable that runs when a new user is created. See the [adduser manual](manpages.ubuntu.com/manpages/artful/man8/adduser) for more information. To apply it:
```bash
sudo ln -v /path/to/repo/usr/local/sbin/adduser.local /usr/local/sbin/adduser.local
```
### Shell configuration, aliases, and functions
- [Ubuntu](https://ubuntu.com) ships with `bash` as its default shell. My favorite shell is [Fish](https://fishshell.com), which I also installed above, using [`fundle`](https://github.com/tuvistavie/fundle) to load some useful plugins from [fundle.plugins](https://github.com/hunter-richardson/shell-config/blob/master/ubuntu/fish/fundle.plugins). I've also written a few functions and aliases that are helpful for my shell in [fish](https://github.com/hunter-richardson/shell-config/blob/master/ubuntu/fish) and its subdirectories. To apply them, follow [these installation instructions](https://github.com/hunter-richardson/shell-config/blob/master/README.md):
```bash
mkdir -p /etc/fish/conf.d/functions /etc/fish/conf.d/completions /etc/bash/conf.d/functions
wget -v https://raw.githubusercontent.com/cheat/cheat/master/cheat/autocompletion/cheat.fish -O /etc/fish/conf.d/completions/cheat.fish
for i in 'bash'
         'fish'
do
  sudo ln -v /path/to/shell-repo/agnostic/$i/conf.d/functions/*.sh /etc/config/$i/conf.d/functions
done
for i in 'bash'
         'bash/conf.d'
         'bash/conf.d/functions'
do
  sudo ln -v /path/to/shell-repo/ubuntu/$i/*.sh /etc/config/$i/
done
for i in 'fish'
         'fish/conf.d'
         'fish/conf.d/functions'
         'fish/conf.d/completions'
do
  sudo ln -v /path/to/shell-repo/ubuntu/fish/$i/*.fish /etc/config/$i/
done
for i in 'functions'
         'completions'
do
  sudo wget https://raw.githubusercontent.com/danhper/fundle/master/$i/fundle.fish -O /root/.config/fish/$i/fundle.fish
  sudo chmod o+x /root/.config/fish/$i/fundle.fish
done
sudo ln -v /path/to/shell-repo/ubuntu/fish/fundle.plugins /root/.config/fish/
sudo fish --command="source /root/.config/fish/plugins.fish"
sudo ln -v /path/to/shell-repo/ubuntu/fish/fish.nanorc /usr/share/nano/
sudo ln -v /path/to/shell-repo/ubuntu/fish/fish.lang /usr/share/source-highlight/
sudo ln -v /path/to/shell-repo/ubuntu/fish/fish.lang /usr/share/gtksourceview-3.0/language-specs/
sudo mkdir -p /etc/tmux
sudo git clone --verbose --depth 1 https://github.com/tmux-plugins/tmux /etc/tmux/tpm
sudo ln -v /path/to/shell-repo/global/tmux/conf /etc/tmux/
printf 'exec tmux -2u -f /etc/tmux/conf' | tee -a ~/.profile
```
### Themes
[Ubuntu](https://ubuntu.com) ships with several themes installed. For cursors, the default is [DMZ-White](https://opendesktop.org/c/1460733789) is the default. I prefer [DMZHaloR32](https://opendesktop.org/c/1460734834). First download it (it should direct a hashed-url similar to `https://dl.opendesktop.org/api/files/downloadfile/id/1460734834/s/.../t/.../u//163336-DMZhaloRP.tar.gz`); to apply it:
```bash
sudo dtrx -nv /path/to/163336-DMZhaloRP.tar.gz
sudo mkdir -p /usr/share/icons/DMZhaloR32
sudo scp -rv /path/to/DMZhaloRP/DMZhaloR32/* /usr/share/icons/DMZhaloR32/
sudo ln -fv /usr/share/icons/DMZhaloR32/cursor.theme /etc/alternatives/x-cursor-theme
sudo srm -lrvz /path/to/DMZhaloRP /path/to/163336-DMZhaloRP.tar.gz
```
### One-time execution for setup
- Quick installation of all software can be attained by the [`source /path/to/repo/install.sh`](install.sh) script. It assumes the `/home` directory is on the right disc and the `root` password has been secured; otherwise it follows the instructions above. Run this only once per installation.
- Quick initialization of users' scripts and files can be attained by the [`source /path/to/repo/users.sh`](users.sh) script. It assumes the above script has been run and all users have been created, otherwise it follows the instructions above. Run this only once per installation.
- Quick setup of downloaded themes (i.e., those not available by SPMs) can be attained by the [`source /path/to/repo/themes.sh`](themes.sh) script. It assumes the theme(s) is/are in the user's `Downloads` directory; otherwise it follows the instructions above.
- Quick application of all configurations, settings, and files can be attained by the [`source /path/to/repo/misc.sh`](misc.sh) script. It assumes the above scripts have been run, otherwise it follows the instructions above. Run this only once per installation. **NOTE:  if anything breaks with this script, the machine will need to be purged _again_.**
### Manual installation of extensions 
Unfortunately and despite popular belief to the contrary, not _everything_ may be automated with CLI scripts, even in Linux.
- The following is a list of links to [Gnome extensions](https://extensions.gnome.org). For users `hunter` and `michelle`, open browse to each link and and flip the switch to apply it, if desired; there is literally no way to automate this. Multiple attempts may be necessary for each extension to register with Gnome.
  - [Add Username to Top Panel](https://extensions.gnome.org/extension/1108) appends the user's full name to the topbar.
  - [Alternate Tab](https://extensions.gnome.org/extension/15) implements a window switcher that resembles MacOS. `Alt Tab` to activate it.
  - [Applications Menu](https://extensions.gnome.org/extension/6) implements a category-based applications menu, accessible from the topbar.
  - [Apt Update Indicator](https://extensions.gnome.org/extension/1139) monitors `apt` for software upgrades and autoremoval stats.
  - [Datetime Format](https://extensions.gnome.org/extension/1173) allows users to customize the datetime format on the status bar.
  - [Extensions](https://extensions.gnome.org/extension/1036) allows users to enable or disable Gnome extensions from the topbar.
  - [Extension Update Notifier](https://extensions.gnome.org/extension/1166) monitors installed Gnome extensions for updates.
  - [Mailnag](https://extensions.gnome.org/extension/886) monitors for email updates to specified addresses.
  - [No Title Bar](https://extensions.gnome.org/extension/1267) removes the title bar from the maximized windows.
  - [Places Status Indicator](https://extensions.gnome.org/extension/8) implements a navigation menu of the userspace.
  - [Suspend Button](https://extensions.gnome.org/extension/826) provides or removes buttons for system suspension and/or deactivation.
  - [Removable Drive Menu](https://extensions.gnome.org/extension/7) implements a navigation and management menu for removable drives.
  - [User Themes](https://extensions.gnome.org/extension/19) allows users to load Gnome-UI themes.
### Miscellaneous configuration
Many of the above Gnome extensions, as well as Gnome itself, have configurable variables. These are available to view and edit either by the `gnome-control-center`, `gnome-tweak-tool`, and `dconf-editor` GUI applications or by the `gsettings` and `dconf` commands. The [`source /path/to/repo/settings.sh`](settings.sh) script will populate as many such variables as are installed with what I think should be the default values. Since many of are user-personal, each user has a specific flavor of the key-values, detailed in his/her/its [_settings.dconf](home/hunter-adm/_settings.dconf) file.
- To load the variables individually as each login user:
```bash
sudo --command="dconf load / < /path/to/repo/home/hunter-adm/_settings.dconf" --user=hunter-adm
sudo --command="dconf load / < /path/to/repo/home/hunter/_settings.dconf" --user=hunter
sudo --command="dconf load / < /path/to/repo/home/michelle/_settings.dconf" --user=michelle
sudo --command="dconf load / < /path/to/repo/etc/skel/_settings.dconf" --user=$(any account created later)
```
- Or the [`source /path/to/repo/settings.sh`](settings.sh) script is available to load the variables for each user automatically.
### Package Control setup
- Install [Package Control](https://packagecontrol.io) on [Sublime Text](https://sublimetext.com/3), which was installed previously. `bat` uses `.sublime-package` packages for custom syntax highlighting.
    - Paste the [Package Control](https://packagecontrol.io/installation) installation script to the Sublime console: Sublime Text -> Ctrl + \` -> Ctrl  + V
    - Connect the Build System:  Sublime Text -> Tools -> Build System -> Python
    - Run the script:  Ctrl + Shift + B -> Enter 'Python'
    - Install Sublime packages: Preferences -> Package Control -> Advanced Install Package -> 'F#,fish,FishTank,MIPS Syntax,MySQL Snippets,OpenGL Shading Language (GLSL),Prolog,sql-formatter,SqlBeautifier,SQLTools,tmux,x86 and x86_64 Assembly'
