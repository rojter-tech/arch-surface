#!/bin/bash
USERHOME=configuration/home
rsync -av $USERHOME/.config/i3/* ~/.config/i3/
rsync -av $USERHOME/.config/systemd/* ~/.config/systemd/
rsync -av $USERHOME/.scripts/* ~/.scripts/
rsync -av $USERHOME/.Xresources ~/.Xresources
rsync -av $USERHOME/.xinitrc ~/.xinitrc
rsync -av $USERHOME/.Xmodmap ~/.Xmodmap
