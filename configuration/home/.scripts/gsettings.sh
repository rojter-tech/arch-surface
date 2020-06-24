#/bin/bash
#  1: exclaim
#  2: at
#  3: numbersign
#  4: dollar
#  5: percent
#  6: asciicircum
#  7: ampersand
#  8: asterisk
#  9: parenleft
#  10: parenright (0)
#  11: underscore (minus)
#  12: plus (equal)


for i in {1..9}; do 
  gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "[]"
  dconf write "/org/gnome/shell/keybindings/switch-to-application-$i" "['']"
  
  gsettings set "org.gnome.shell.extensions.dash-to-dock" "app-hotkey-$i" "[]"
  dconf write "/org/gnome/shell/extensions/dash-to-dock/app-hotkey-$i" "['']"

  gsettings set "org.gnome.shell.extensions.dash-to-dock" "app-shift-hotkey-$i" "[]"
  dconf write "/org/gnome/shell/extensions/dash-to-dock/app-shift-hotkey-$i" "['']"

  gsettings set "org.gnome.shell.extensions.dash-to-dock" "app-ctrl-hotkey-$i" "[]"
  dconf write "/org/gnome/shell/extensions/dash-to-dock/app-ctrl-hotkey-$i" "['']"

  gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Super>$i', '<Alt>$i']"
  dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-$i" "['<Super>$i', '<Alt>$i']"
  
  echo $i done.
done
