#!/bin/bash
USERHOME=configuration/home
# root dirs
mkdir -p ~/.config/i3; rsync -av $USERHOME/.config/i3/* ~/.config/i3/
mkdir -p ~/.config/systemd; rsync -av $USERHOME/.config/systemd/* ~/.config/systemd/
mkdir -p ~/.scripts; rsync -av $USERHOME/.scripts/* ~/.scripts/
mkdir -p ~/.xmonad; rsync -av $USERHOME/.xmonad/* ~/.xmonad/
# root files
rsync -av $USERHOME/.Xresources ~/.Xresources
rsync -av $USERHOME/.xinitrc ~/.xinitrc
rsync -av $USERHOME/.Xmodmap ~/.Xmodmap
