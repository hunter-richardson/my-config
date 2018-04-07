# my-config
This is the repository for my home computer's setup.
## A rundown of what's stored here.
- [Software packages and repositories](#software-packages-and-repositories)
- [Operating system and program configuration](#operating-system-and-program-configuration)
- [Shell configuration, aliases, and functions](#shell-configuration-aliases-and-functions)
- [Themes](#themes)
- [User files](#user-files)
- [One-time execution for setup](#one-time-execution-for-setup)
- Installation instructions (i.e., [what you're reading now](README.md))
---
## But first
I like having my non-root userspace (i.e., `/home/*`) mounted onto a separate disk. So far, [Ubuntu](https://ubuntu.com) has labeled this disk `/dev/sdb`. Getting `/home` mounted is a pain, but seeing as I've had to do it a few times, I think I've got it down. The script [rehome](rehome) will perform this action.
    ```shell
       source /path/to/repo/rehome
    ```

Since it involves wiping the files in `/home`, it will be easier to run in an `Ctrl Alt F1` shell.
## Some detail
### Software packages and repositories
- [Ubuntu](https://ubuntu.com) ships with its own PPAs installed. [dpkg.apt.sources](dpkg.apt.sources) contains a list of my custom PPA keys. To load them:
    ```shell
       for i in $(cat /path/to/repo/dpkg.apt.sources)
         sudo add-apt-repository -y $i
       end
    ```
- [dpkg.apt](dpkg.apt) contains the software packages I've installed via `apt`. To install them:
    ```shell
       sudo apt-get install -y $(cat /path/to/repo/dpkg.apt)
    ```
- For packages [Ubuntu](https://ubuntu.com) doesn't offer in public, artful-secure PPAs, [Snaps](https://snapcraft.io) may do the trick. [dpkg.snap](dpkg.snap) contains the software packages I've installed via `snap`. To install them:
    ```shell
       sudo snap install $(cat /path/to/repo/dpkg.snap)
    ```
- For packages [Ubuntu](https://ubuntu.com) doesn't offer in PPAs or as Snaps, I looked elsewhere. [./dpkg.pip3](dpkg.pip3) contains the [Python](https://python.org) software package I use. To install it:
    ```shell
       sudo pip3 install $(cat /path/to/repo/dpkg.pip3)
    ```
- Finally, for packages I simply could not find as prebuilt binaries, I installed from [Github](https://github.com). [dpkg.git](dpkg.git) contains the Github repositories I use, except [my-config](#). To install them globally (i.e., in this repo's parent directory):
    ```shell
       for i in $(cat /path/to/repo/dpkg.git)
         set repo=$(echo $i | cut -d'/' -f2)
         sudo git clone --verbose --depth 1 https://github.com/$i /path/to/repo/../$repo
         set repo=
       end
    ```
### Operating system and program configuration
- [Ubuntu](https://ubuntu.com) ships with `apt` well-configured for the average user's needs -- but I'm not the average user. [apt.conf.d](etc/apt/apt.conf.d) contains my custom `apt` configuration. See the [apt.conf manual](https://linux.die.net/man/5/apt.conf) for more information. To use it:
    ```shell
       sudo mkdir -p /etc/apt/apt.conf.d
       sudo scp -rv /path/to/repo/etc/apt/apt.conf.d/* /etc/apt/apt.conf.d/
    ```
    I also installed [`apt-fast`](https://github.com/ilikenwf/apt-fast) above. [apt-fast.conf](etc/apt-fast.conf) contains my configuration for it. To use it:
    ```shell
       sudo scp -v /path/to/repo/etc/apt-fast.conf /etc/apt-fast.conf
    ```
- [Ubuntu](https://ubuntu.com) ships with `gdm3` as its default login greeter. Currently, my favorite greeter is `LightDM`, which I also installed above. [lightdm](etc/lightdm) and its subdirectory contains my `LightDM` configuration. To use them:
    ```shell
       sudo mkdir -p /etc/lightdm
       sudo scp -rv /path/to/repo/etc/lightdm/* /etc/lightdm/
    ```
- [login.defs](etc/login.defs) contains setup flags related to user login, authentication, and permissions. See the [login.defs manual](http://man7.org/linux/man-pages/man5/login.defs.5.html) for more information. To use it:
    ```shell
       sudo scp -v /path/to/repo/etc/login.defs /etc/login.defs
    ```
- Call me a heathen or whatever, but I use [`nano`](https://nano-editor.org) as my default text editor. [nanorc](etc/nanorc) contains its configuration. To use it:
    ```shell
       sudo scp -v /path/to/repo/etc/nanorc /etc/nanorc
    ```
- [sudoers](etc/sudoers) contains additional setup flags related to user authentication and permissions. To use it:
    ```shell
       sudo scp -v /path/to/repo/etc/sudoers /etc/sudoers
    ```
- `tmux` is a terminal multiplexer that sets up a status bar and allows windows to split into panes. [tmux.conf](etc/tmux.conf) contains my tmux configuration file. See the [tmux manual](https://man.openbsd.org/OpenBSD-current/man1/tmux.1) for more information. To use it:
    ```shell
       sudo scp -v /path/to/repo/etc/tmux.conf /etc/tmux.conf
    ```
- `w3m` is a terminal internet browser. [config](etc/w3m/config) contains my `w3m` configuration file. To use it:
    ```shell
       sudo scp -v /path/to/repo/etc/w3m /etc/w3m
    ```
- [adduser.local](usr/local/sbin/adduser.local) defines an executable that runs when a new user is created. See the [adduser manual](manpages.ubuntu.com/manpages/artful/man8/adduser) for more information. To use it:
    ```shell
       sudo scp -v /path/to/repo/usr/local/sbin/adduser.local /usr/local/sbin/adduser.local
    ```
### Shell configuration, aliases, and functions
- [Ubuntu](https://ubuntu.com) ships with `bash` as its default shell. My favorite shell is [Fish](https://fishshell.com), which I also installed above. I've written a few functions and aliases that are helpful for my shell in [fish](etc/fish) and its subdirectories. To install them:
    ```shell
       sudo mkdir -p /etc/fish
       sudo scp -rv /path/to/repo/etc/fish/* /etc/fish/
    ```
    [fish.lang](usr/share/gtksourceview-3.0/language-specs/fish.lang) and [fish.nanorc](usr/share/nano/fish.nanorc) contain configuration for syntax-highlighting of Fish scripts, in `gedit` and `nano`, respectively. To use them:
    ```shell
       sudo scp -v /path/to/repo/usr/share/gtksourceview-3.0/language-specs/fish.lang /usr/share/gtksourceview-3.0/language-specs/
       sudo scp -v /path/to/repo/usr/share/nano/fish.nanorc /usr/share/nano/
    ```
    [Also, each user intending to use the shell should install a configuration file at home.](#user)
- To use Fish by default without going through the whole `cshs` trouble, I run a script at the bottom of [bash.bashrc](etc/bash.bashrc) which opens a `tmux` session into Fish. (Make sure both `tmux` and `fish` work before using this!) To run it:
    ```shell
       sudo scp -v /path/to/repo/etc/bash.bashrc /etc/bash.bashrc
    ```
### Themes
- [Ubuntu](https://ubuntu.com) ships with several cursor themes installed. [DMZ-White](https://gnome-look.org/content/show.php/?content=159847) is the default. I prefer [DMZHaloRP](https://gnome-look.org/p/999745), stored at [DMZhaloR24](usr/share/icons/DMZhaloR24). To use them:
    ```shell
       sudo scp -v /path/to/repo/usr/share/icons/DMZhaloR24 /usr/share/icons/
    ```
### User files
- My regular user account is `hunter`. His files are stored in [hunter](home/hunter).
- My administrative account is `hunter-adm`. His files are stored in [hunter-adm](home/hunter-adm).
- The owner of all files not specific to any user is, of course, `root`. Its files are stored in [root](root).
- Each user above executes `$HOME/.config/fish/config.fish` (e.g., [config.fish](home/hunter/.config/fish/config.fish)) upon opening a Fish shell.
- Each user above has a `$HOME/.config/git/config file` (e.g., [config](home/hunter/.config/git/config)) with `git`-related configuration settings. Currently, they're identical.
### One-time execution for setup
- Quick duplication of all configurations, settings, and files can be attained by executing [`source /path/to/repo/misc`](misc). It includes these instructions, plus some additional settings I haven't detailed. Run this only once per installation.
