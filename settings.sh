#!/bin/bash

set user=$(whoami)

case "$user" in
  root)
    gsettings set ca.desrt.dconf-editor.Settings show-warning false
    gsettings set ca.desrt.dconf-editor.Settings sort-case-sensitive false
    gsettings set ca.desrt.dconf-editor.Settings window-is-maximized true
    gsettings set com.canonical.indicator.datetime alarm-haptic-feedback 'none'
    gsettings set com.canonical.indicator.datetime show-calendar true
    gsettings set com.canonical.indicator.datetime show-clock true
    gsettings set com.canonical.indicator.datetime show-date true
    gsettings set com.canonical.indicator.datetime show-day true
    gsettings set com.canonical.indicator.datetime show-year true
    gsettings set com.canonical.indicator.datetime timezone-name 'Central'
    gsettings set com.canonical.indicator.power icon-policy 'never'
    gsettings set com.canonical.unity-greeter background '/usr/share/backgrounds/warty-final-ubuntu.png'
    gsettings set com.canonical.unity-greeter background-color '#2C001E'
    gsettings set com.canonical.unity-greeter background-logo '/usr/share/unity-greeter/cof.png'
    gsettings set com.canonical.unity-greeter draw-grid false
    gsettings set com.canonical.unity-greeter draw-user-backgrounds false
    gsettings set com.canonical.unity-greeter font-name 'Ubuntu 11'
    gsettings set com.canonical.unity-greeter icon-theme-name 'Flat-Remix-Dark'
    gsettings set com.canonical.unity-greeter logo '/usr/share/unity-greeter/logo.png'
    gsettings set com.canonical.unity-greeter play-ready-sound false
    gsettings set com.canonical.unity-greeter theme-name 'Matcha-dark-azul'
    gsettings set com.canonical.unity-greeter xft-hintstyle 'hintslight'
    gsettings set com.ubuntu.touch.network gps false
    gsettings set com.ubuntu.touch.sound silent-mode true
    gsettings set com.ubuntu.touch.system rotation-lock true
    gsettings set com.ubuntu.update-notifier no-show-notifications false
    gsettings set com.ubuntu.update-notifier show-apport-crashes true
    gsettings set com.ubuntu.user-interface.desktop cursor-size 32
    gsettings set org.gnome.eog.ui disable-trash-confirmation false
    gsettings set org.gnome.eog.ui image-gallery true
    gsettings set org.gnome.eog.ui image-gallery-position 'left'
    gsettings set org.gnome.eog.ui image-gallery-resizable true
    gsettings set org.gnome.eog.ui propsdialog-netbook-mode false
    gsettings set org.gnome.eog.ui scroll-buttons false
    gsettings set org.gnome.eog.ui statusbar false
    gsettings set org.gnome.gedit.plugins active-plugins "['docinfo', 'externaltools', 'filebrowser', 'modelines', 'pythonconsole', 'quickopen', 'sort', 'snippets', 'spell', 'time']"
    gsettings set org.gnome.gedit.plugins.filebrowser enable-remote true
    gsettings set org.gnome.gedit.plugins.filebrowser.nautilus confirm-trash false
    gsettings set org.gnome.gedit.plugins.pythonconsole font 'Hack 10'
    gsettings set org.gnome.gedit.plugins.time custom-format '%a %e %B %Y, %H%M %Z'
    gsettings set org.gnome.gedit.plugins.time prompt-type 'use-custom-format'
    gsettings set org.gnome.gedit.preferences.editor auto-indent true
    gsettings set org.gnome.gedit.preferences.editor bracket-matching true
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor display-overview-map true
    gsettings set org.gnome.gedit.preferences.editor editor-font 'Hack 10'
    gsettings set org.gnome.gedit.preferences.editor ensure-trailing-newline true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor scheme 'cobalt'
    gsettings set org.gnome.gedit.preferences.editor search-highlighting true
    gsettings set org.gnome.gedit.preferences.editor syntax-highlighting true
    gsettings set org.gnome.gedit.preferences.editor tabs-size 2
    gsettings set org.gnome.gnome-system-monitor show-whose-processes 'all'
    gsettings set org.gnome.login-screen allowed-failures 5
    gsettings set org.gnome.login-screen disable-user-list false
    gsettings set org.gnome.login-screen enable-password-authentication true
    gsettings set org.gnome.login-screen enable-smartcard-authentication false
    gsettings set org.gnome.nautilus.compression default-compression-format 'tar.xz'
    gsettings set org.gnome.nautilus.desktop home-icon-visible false
    gsettings set org.gnome.nautilus.desktop network-icon-visible false
    gsettings set org.gnome.nautilus.desktop trash-icon-visible false
    gsettings set org.gnome.nautilus.desktop volumes-visible true
    gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'owner', 'date_modified_with_time']"
    gsettings set org.gnome.nautilus.preferences always-use-location-entry true
    gsettings set org.gnome.nautilus.preferences confirm-trash false
    gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
    gsettings set org.gnome.nautilus.preferences mouse-back-button 0
    gsettings set org.gnome.nautilus.preferences mouse-forward-button 0
    gsettings set org.gnome.nautilus.preferences mouse-use-extra-buttons false
    gsettings set org.gnome.nautilus.preferences show-create-link true
    gsettings set org.gnome.nautilus.preferences show-delete-permanently true
    gsettings set org.gnome.nautilus.preferences show-hidden-files true
    gsettings set org.gnome.online-accounts whitelisted-providers ['']
    gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 4800
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 4800
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
    gsettings set org.gnome.software external-appstream-system-wide true
    ;;
  *)
    set home_dir=$(getent passwd $user | cut -d':' -f6)
    gsettings set ca.desrt.dconf-editor.Settings show-warning false
    gsettings set ca.desrt.dconf-editor.Settings sort-case-sensitive false
    gsettings set ca.desrt.dconf-editor.Settings window-is-maximized true
    gsettings set com.canonical.indicator.datetime alarm-haptic-feedback 'none'
    gsettings set com.canonical.indicator.datetime show-calendar true
    gsettings set com.canonical.indicator.datetime show-clock true
    gsettings set com.canonical.indicator.datetime show-date true
    gsettings set com.canonical.indicator.datetime show-day true
    gsettings set com.canonical.indicator.datetime show-year true
    gsettings set com.canonical.indicator.datetime timezone-name 'Central'
    gsettings set com.canonical.indicator.power icon-policy 'never'
    gsettings set com.canonical.unity-greeter background '/usr/share/backgrounds/warty-final-ubuntu.png'
    gsettings set com.canonical.unity-greeter background-color '#2C001E'
    gsettings set com.canonical.unity-greeter background-logo '/usr/share/unity-greeter/cof.png'
    gsettings set com.canonical.unity-greeter draw-grid false
    gsettings set com.canonical.unity-greeter draw-user-backgrounds false
    gsettings set com.canonical.unity-greeter font-name 'Ubuntu 11'
    gsettings set com.canonical.unity-greeter icon-theme-name 'Flat-Remix-Dark'
    gsettings set com.canonical.unity-greeter logo '/usr/share/unity-greeter/logo.png'
    gsettings set com.canonical.unity-greeter play-ready-sound false
    gsettings set com.canonical.unity-greeter theme-name 'Matcha-dark-azul'
    gsettings set com.canonical.unity-greeter xft-hintstyle 'hintslight'
    gsettings set com.ubuntu.touch.network gps false
    gsettings set com.ubuntu.touch.sound silent-mode true
    gsettings set com.ubuntu.touch.system rotation-lock true
    gsettings set com.ubuntu.update-notifier no-show-notifications false
    gsettings set com.ubuntu.update-notifier show-apport-crashes true
    gsettings set com.ubuntu.user-interface.desktop cursor-size 32
    gsettings set org.gnome.calculator base 10
    gsettings set org.gnome.calculator button-mode 'keyboard'
    gsettings set org.gnome.calculator show-thousands true
    gsettings set org.gnome.calculator show-zeroes false
    gsettings set org.gnome.calendar active-view 'month'
    gsettings set org.gnome.desktop.a11y always-show-text-caret false
    gsettings set org.gnome.desktop.a11y always-show-universal-access-status false
    gsettings set org.gnome.desktop.a11y.keyboard togglekeys-enable true
    gsettings set org.gnome.desktop.app-folders folder-children []
    gsettings set org.gnome.desktop.background draw-background true
    gsettings set org.gnome.desktop.background picture-options 'spanned'
    gsettings set org.gnome.desktop.calendar show-weekdate true
    gsettings set org.gnome.desktop.datetime automatic-timezone true
    gsettings set org.gnome.desktop.file-sharing bluetooth-accept-files 'ask'
    gsettings set org.gnome.desktop.file-sharing require-password 'always'
    gsettings set org.gnome.desktop.interface buttons-have-icons true
    gsettings set org.gnome.desktop.interface clock-format '24h'
    gsettings set org.gnome.desktop.interface clock-show-date true
    gsettings set org.gnome.desktop.interface clock-show-seconds false
    gsettings set org.gnome.desktop.interface cursor-blink true
    gsettings set org.gnome.desktop.interface cursor-theme 'DMZhaloR32'
    gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
    gsettings set org.gnome.desktop.interface gtk-theme 'Matcha-dark-azul'
    gsettings set org.gnome.desktop.interface icon-theme 'Flat-Remix-Dark'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Hack 10'
    gsettings set org.gnome.desktop.interface show-battery-percentage false
    gsettings set org.gnome.desktop.interface show-input-method-menu false
    gsettings set org.gnome.desktop.interface show-unicode-menu false
    gsettings set org.gnome.desktop.media-handling automount true
    gsettings set org.gnome.desktop.media-handling automount-open false
    gsettings set org.gnome.desktop.media-handling autorun-never true
    gsettings set org.gnome.desktop.notifications show-in-lock-screen false
    gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'adaptive'
    gsettings set org.gnome.desktop.peripherals.touchpad click-method 'none'
    gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
    gsettings set org.gnome.desktop.peripherals.touchpad left-handed 'right'
    gsettings set org.gnome.desktop.peripherals.touchpad scroll-method 'disabled'
    gsettings set org.gnome.desktop.peripherals.touchpad send-events 'disabled'
    gsettings set org.gnome.desktop.peripherals.touchpad tap-and-drag false
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
    gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled false
    gsettings set org.gnome.desktop.privacy hide-identity true
    gsettings set org.gnome.desktop.privacy old-files-age 5
    gsettings set org.gnome.desktop.privacy remove-old-temp-files true
    gsettings set org.gnome.desktop.privacy remove-old-trash-files true
    gsettings set org.gnome.desktop.privacy report-technical-problems true
    gsettings set org.gnome.desktop.privacy send-software-usage-stats true
    gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar true
    gsettings set org.gnome.desktop.screensaver picture-options 'spanned'
    gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'
    gsettings set org.gnome.desktop.screensaver show-full-name-in-top-bar true
    gsettings set org.gnome.desktop.screensaver show-notifications false
    gsettings set org.gnome.desktop.screensaver status-message-enabled true
    gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend true
    gsettings set org.gnome.desktop.screensaver user-switch-enabled true
    gsettings set org.gnome.desktop.sound event-sounds true
    gsettings set org.gnome.desktop.sound theme-name '__custom'
    gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'toggle-shade'
    gsettings set org.gnome.desktop.wm.preferences auto-raise true
    gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
    gsettings set org.gnome.desktop.wm.preferences resize-with-right-button false
    gsettings set org.gnome.desktop.wm.preferences theme 'Adwaita'
    gsettings set org.gnome.eog.ui disable-trash-confirmation true
    gsettings set org.gnome.eog.ui image-gallery true
    gsettings set org.gnome.eog.ui image-gallery-position 'left'
    gsettings set org.gnome.eog.ui image-gallery-resizable true
    gsettings set org.gnome.eog.ui propsdialog-netbook-mode false
    gsettings set org.gnome.eog.ui scroll-buttons false
    gsettings set org.gnome.eog.ui statusbar false
    gsettings set org.gnome.gedit.plugins active-plugins "['docinfo', 'externaltools', 'filebrowser', 'modelines', 'pythonconsole', 'quickopen', 'sort', 'snippets', 'spell', 'time']"
    gsettings set org.gnome.gedit.plugins.filebrowser enable-remote true
    gsettings set org.gnome.gedit.plugins.filebrowser.nautilus confirm-trash false
    gsettings set org.gnome.gedit.plugins.pythonconsole font 'Hack 10'
    gsettings set org.gnome.gedit.plugins.time custom-format '%a %e %B %Y, %H%M %Z'
    gsettings set org.gnome.gedit.plugins.time prompt-type 'use-custom-format'
    gsettings set org.gnome.gedit.preferences.editor auto-indent true
    gsettings set org.gnome.gedit.preferences.editor bracket-matching true
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor display-overview-map true
    gsettings set org.gnome.gedit.preferences.editor editor-font 'Hack 10'
    gsettings set org.gnome.gedit.preferences.editor ensure-trailing-newline true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor scheme 'cobalt'
    gsettings set org.gnome.gedit.preferences.editor search-highlighting true
    gsettings set org.gnome.gedit.preferences.editor syntax-highlighting true
    gsettings set org.gnome.gedit.preferences.editor tabs-size 2
    gsettings set org.gnome.gnome-screenshot auto-save-directory '$home_dir/Pictures/screenshots'
    gsettings set org.gnome.gnome-screenshot default-file-type 'png'
    gsettings set org.gnome.gnome-screenshot include-border false
    gsettings set org.gnome.gnome-screenshot include-pointer false
    gsettings set org.gnome.login-screen allowed-failures 5
    gsettings set org.gnome.login-screen disable-user-list false
    gsettings set org.gnome.login-screen enable-password-authentication true
    gsettings set org.gnome.login-screen enable-smartcard-authentication false
    gsettings set org.gnome.mutter dynamic-workspaces false
    gsettings set org.gnome.nautilus.compression default-compression-format 'tar.xz'
    gsettings set org.gnome.nautilus.desktop home-icon-visible false
    gsettings set org.gnome.nautilus.desktop network-icon-visible false
    gsettings set org.gnome.nautilus.desktop trash-icon-visible false
    gsettings set org.gnome.nautilus.desktop volumes-visible true
    gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'owner', 'date_modified_with_time']"
    gsettings set org.gnome.nautilus.preferences always-use-location-entry true
    gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
    gsettings set org.gnome.nautilus.preferences mouse-back-button 0
    gsettings set org.gnome.nautilus.preferences mouse-forward-button 0
    gsettings set org.gnome.nautilus.preferences mouse-use-extra-buttons false
    gsettings set org.gnome.nautilus.preferences show-create-link true
    gsettings set org.gnome.nm-applet suppress-wireless-networks-available true
    gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state 'on'
    gsettings set org.gnome.settings-daemon.peripherals.keyboard remember-numlock-state true
    gsettings set org.gnome.settings-daemon.peripherals.mouse locate-pointer true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
    gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 4800
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 4800
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'slight'
    gsettings set org.gnome.shell enabled-extensions "['add-username-toppanel@brendaw.com', 'alternate-tab@gnome-shell-extensions.gcampax.github.com', 'apt-update-indicator@franglais125.gmail.com', 'datetime-format@Daniel-Khodabakhsh.github.com', 'update-extensions@franglais125.gmail.com', 'no-title-bar@franglais125.gmail.com', 'openweather-extension@jenslody.de', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'suspend-button@laserb', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'apps-menu@gnome-shell-extensions.gcampax.github.com', 'mailnag@pulb.github.com']"
    dconf write /org/gnome/shell/extensions/apt-update-indicator/always-visible false
    dconf write /org/gnome/shell/extensions/apt-update-indicator/check-cmd-version "'pkexec apt update'"
    dconf write /org/gnome/shell/extensions/apt-update-indicator/interval-unit "'days'"
    dconf write /org/gnome/shell/extensions/apt-update-indicator/notify true
    dconf write /org/gnome/shell/extensions/apt-update-indicator/output-on-terminal true
    dconf write /org/gnome/shell/extensions/apt-update-indicator/strip-versions true
    dconf write /org/gnome/shell/extensions/apt-update-indicator/terminal "'gnome-terminal -x fish -c'"
    dconf write /org/gnome/shell/extensions/apt-update-indicator/update-cmd "'pkexec apt upgrade -y'"
    dconf write /org/gnome/shell/extensions/apt-update-indicator/update-cmd-options "'custom'"
    dconf write /org/gnome/shell/extensions/apt-update-indicator/use-custom-cmd true
    dconf write /org/gnome/shell/extensions/apt-update-indicator/verbosity 2
    dconf write /org/gnome/shell/extensions/datetime-format/datemenudate-format "'%A, %e %B %Y'"
    dconf write /org/gnome/shell/extensions/datetime-format/datemenuday-format "'%A %e %B'"
    dconf write /org/gnome/shell/extensions/datetime-format/statusbar-format "'%A %e %B %Y, %H%M %Z'"
    dconf write /org/gnome/shell/extensions/extensions/position "'panel'"
    dconf write /org/gnome/shell/extensions/extensions/show-add true
    dconf write /org/gnome/shell/extensions/no-title-bar/buttons-for-snapped true
    dconf write /org/gnome/shell/extensions/no-title-bar/hide-buttons false
    dconf write /org/gnome/shell/extensions/no-title-bar/only-main-monitor true
    dconf write /org/gnome/shell/extensions/openweather/actual-city 0
    dconf write /org/gnome/shell/extensions/openweather/appid-fc "'5f45bf8521e04c2e702c6f5a2208adba'"
    dconf write /org/gnome/shell/extensions/openweather/center-forecast true
    dconf write /org/gnome/shell/extensions/openweather/city "'34.663253, -86.718080>Huntsville, AL>1'"
    dconf write /org/gnome/shell/extensions/openweather/days-forecast 3
    dconf write /org/gnome/shell/extensions/openweather/decimal-places 0
    dconf write /org/gnome/shell/extensions/openweather/geolocation-provider "'geocode'"
    dconf write /org/gnome/shell/extensions/openweather/position-in-panel "'right'"
    dconf write /org/gnome/shell/extensions/openweather/pressure-unit "'atm'"
    dconf write /org/gnome/shell/extensions/openweather/refresh-interval-current 600
    dconf write /org/gnome/shell/extensions/openweather/refresh-interval-forecast 600
    dconf write /org/gnome/shell/extensions/openweather/show-comment-in-forecast true
    dconf write /org/gnome/shell/extensions/openweather/show-comment-in-panel false
    dconf write /org/gnome/shell/extensions/openweather/show-text-in-panel true
    dconf write /org/gnome/shell/extensions/openweather/translate-condition true
    dconf write /org/gnome/shell/extensions/openweather/unit "'fahrenheit'"
    dconf write /org/gnome/shell/extensions/openweather/use-default-owm-key true
    dconf write /org/gnome/shell/extensions/openweather/use-symbolic-icons true
    dconf write /org/gnome/shell/extensions/openweather/weather-provider "'darksky.net'"
    dconf write /org/gnome/shell/extensions/openweather/wind-direction true
    dconf write /org/gnome/shell/extensions/openweather/wind-speed-unit "'mph'"
    dconf write /org/gnome/shell/extensions/suspend-button/show-two-buttons false
    dconf write /org/gnome/shell/extensions/update-extensions/interval-unit "'days'"
    dconf write /org/gnome/shell/extensions/update-extensions/system-wide-ext true
    dconf write /org/gnome/shell/extensions/update-extensions/transient true
    dconf write /org/gnome/shell/extensions/user-theme/name "'Matcha-dark-azul'"
    gsettings set org.gnome.shell.window-switcher app-icon-mode 'thumbnail-only'
    gsettings set org.gnome.software external-appstream-system-wide true
    gsettings set org.gnome.software show-ratings true
    gsettings set org.gnome.system.location enabled true
    gsettings set org.gnome.system.location max-accuracy-level 'neighborhood'
    gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'tab'
    gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
    gsettings set org.gnome.Terminal.Legacy.Settings tab-position 'top'
    dconf write /org/gtk/Settings/FileChooser/clock-format "'24h'"
    dconf write /org/gtk/Settings/FileChooser/date-format "'with-time'"
    dconf write /org/gtk/Settings/FileChooser/location-mode "'path-bar'"
    dconf write /org/gkt/Settings/FileChooser/show-size-column true
    dconf write /org/gtk/Settings/FileChooser/sort-column "'name'"
    dconf write /org/gtk/Settings/FileChooser/sort-directories-first true
    dconf write /org/gtk/Settings/FileChooser/sort-order "'ascending'"
    if [ -f $home_dir/Pictures/wallpaper.png ] ; then
      gsettings set org.gnome.desktop.background picture-uri 'file://$home_dir/Pictures/wallpaper.png'
    else if [ -f $home_dir/Pictures/wallpaper.jpg ] ; then
      gsettings set org.gnome.desktop.background picture-uri 'file://$home_dir/Pictures/wallpaper.jpg'
    else if [ -f $home_dir/Pictures/wallpaper.jpeg ] ; then
      gsettings set org.gnome.desktop.background picture-uri 'file://$home_dir/Pictures/wallpaper.jpeg'
    else
      gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/warty-final-ubuntu.png'
    fi
    gsettings set com.canonical.unity-greeter background 'file:///usr/share/backgrounds/warty-final-ubuntu.png'
    case "$user" in
      hunter-adm)
        gsettings set org.gnome.gnome-system-monitor show-whose-processes 'all'
        gsettings set org.gnome.nautilus.preferences confirm-trash false
        gsettings set org.gnome.nautilus.preferences show-delete-permanently true
        gsettings set org.gnome.nautilus.preferences show-hidden-files true
        gsettings set org.gnome.online-accounts whitelisted-providers ['']
        gsettings set org.gnome.Terminal.Legacy.Settings confirm-close false
        gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
        dconf write /org/gtk/Settings/FileChooser/show-hidden true
        ;;
      hunter)
        gsettings set org.gnome.gnome-system-monitor show-whose-processes 'all'
        gsettings set org.gnome.nautilus.preferences confirm-trash false
        gsettings set org.gnome.nautilus.preferences show-delete-permanently true
        gsettings set org.gnome.nautilus.preferences show-hidden-files true
        gsettings reset org.gnome.online-accounts whitelisted-providers
        gsettings set org.gnome.rhythmbox.player play-order 'shuffle'
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar app-menu-display true
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar compact-progressbar true
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar dark-theme true
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar volume-control true
        gsettings set org.gnome.rhythmbox queue-as-sidebar true
        gsettings set org.gnome.rhythmbox.sharing enable-browsing true
        gsettings set org.gnome.rhythmbox.sharing enable-sharing true
        gsettings set org.gnome.rhythmbox.sharing require-password true
        gsettings set org.gnome.shell.extensions.mailnag max-visible-emails 15
        gsettings set org.gnome.shell.extensions.mailnag remove-indicator true
        gsettings set org.gnome.shell.extensions.mailnag show-avatars true
        gsettings set org.gnome.shell.extensions.mailnag show-check-for-mail-button false
        gsettings set org.gnome.shell.extensions.mailnag show-dates true
        gsettings set org.gnome.shell.extensions.mailnag show-mark-all-as-read-button false
        gsettings set org.gnome.shell.extensions.mailnag show-settings-button true
        gsettings set org.gnome.shell favorite-apps ['firefox.desktop']
        dconf write /org/gtk/Settings/FileChooser/show-hidden true
        ;;
      *)
        gsettings set org.gnome.gnome-system-monitor show-whose-processes 'user'
        gsettings set org.gnome.nautilus.preferences confirm-trash true
        gsettings set org.gnome.nautilus.preferences show-delete-permanently false
        gsettings set org.gnome.nautilus.preferences show-hidden-files false
        gsettings reset org.gnome.online-accounts whitelisted-providers
        gsettings set org.gnome.rhythmbox.player play-order 'shuffle'
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar app-menu-display true
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar compact-progressbar true
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar dark-theme true
        gsettings set org.gnome.rhythmbox.plugins.alternative_toolbar volume-control true
        gsettings set org.gnome.rhythmbox queue-as-sidebar true
        gsettings set org.gnome.rhythmbox.sharing enable-browsing true
        gsettings set org.gnome.rhythmbox.sharing enable-sharing true
        gsettings set org.gnome.rhythmbox.sharing require-password true
        dconf write /org/gtk/Settings/FileChooser/show-hidden false
        ;;
    esac
    ;;
esac

set user= 
set home_dir= 

