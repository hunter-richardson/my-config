- Install [Package Control](https://packagecontrol.io) on [Sublime Text](https://sublimetext.com/3), installed previously.
    - Paste the [Sublime Build System for Python 3](https://raw.githubusercontent.com/shikharkunal99/Sublime-Build-System/master/pythonBS.sublime-build) to Sublime Text -> Tools -> Build System -> New Build System -> 'Python':
```bash
xset -b --input https://raw.githubusercontent.com/shikharkunal99/Sublime-Build-System/master/pythonBS.sublime-build
```
    - Save the [Package Control](https://packagecontrol.io/installation) installation script:
```bash
echo $(curl -sk --raw https://packagecontrol.io/installation | grep 'Package Control.sublime-package')[1] | sed 's/;[[:space:]]/\n/g' | awk '{$1=$1};1' | tee ~/Downloads/packagecontrol.py
```
    - Open the installation script:  Sublime Text -> Open -> packagecontrol.py
    - Connect the script to the new Build:  Sublime Text -> Tools -> Build System -> Python
    - Run the script:  Ctrl + Shift + B

