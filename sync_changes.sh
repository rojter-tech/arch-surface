#!/bin/bash
USERHOME=configuration/home
SYSTEM=configuration/system
# home dirs
mkdir -p ~/.config/i3; rsync -av $USERHOME/.config/i3/* ~/.config/i3/
mkdir -p ~/.config/systemd; rsync -av $USERHOME/.config/systemd/* ~/.config/systemd/
mkdir -p ~/.scripts; rsync -av $USERHOME/.scripts/* ~/.scripts/
mkdir -p ~/.xmonad; rsync -av $USERHOME/.xmonad/* ~/.xmonad/
# home files
rsync -av $USERHOME/.Xresources ~/.Xresources
rsync -av $USERHOME/.xinitrc ~/.xinitrc
rsync -av $USERHOME/.Xmodmap ~/.Xmodmap

# system files
sudo rsync $USERHOME/.config/i3/i3status.conf /etc/i3status.conf