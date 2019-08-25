#!/bin/sh
# ~/.xinitrc
feh --bg-scale ~/.xmonad/matrix_code-wallpaper-3000x2000.jpg

# Executed by startx (run your window manager from here)
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [systemd-detect-virt = "oracle"];
	/usr/bin/VBoxClient-all
fi
