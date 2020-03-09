#!/bin/bash
USERHOME=configuration/home
SYSTEM=configuration/system
# home dirs
mkdir -p ~/.scripts; rsync -av $USERHOME/.scripts/* ~/.scripts/
mkdir -p ~/.xmonad; rsync -av $USERHOME/.xmonad/* ~/.xmonad/
mkdir -p ~/.screenlayout; rsync -av $USERHOME/.screenlayout/* ~/.screenlayout/
mkdir -p ~/.config/i3; rsync -av $USERHOME/.config/i3/* ~/.config/i3/
mkdir -p ~/.config/polybar; rsync -av $USERHOME/.config/polybar/* ~/.config/polybar/
mkdir -p ~/.config/systemd; rsync -av $USERHOME/.config/systemd/* ~/.config/systemd/
# home files
rsync -av $USERHOME/.Xresources ~/.Xresources
rsync -av $USERHOME/.xinitrc ~/.xinitrc
rsync -av $USERHOME/.Xmodmap ~/.Xmodmap
rsync -av $USERHOME/.xmobarrc ~/.xmobarrc

# system files
sudo rsync $USERHOME/.config/i3/i3status.conf /etc/i3status.conf
sudo rsync $SYSTEM/etc/X11/xorg.conf.d/10-monitor.conf /etc/X11/xorg.conf.d/10-monitor.conf
sudo rsync $SYSTEM/etc/profile.d/hidpi.sh /etc/profile.d/hidpi.sh
