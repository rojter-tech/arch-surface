#!/bin/bash
setxkbmap -option 'grp:alt_shift_toggle' -layout us,se -variant qwerty
numlockx on
eval `ssh-agent`
xrdb -load ~/.Xresources
~/.screenlayout/1920x1080/top/top_external.sh
feh --bg-scale ~/.xmonad/bg/code-coding_3840x2400.jpg
(sudo killall conky; conky -c $HOME/.xmonad/scripts/system-overview) &
(sleep 5; /usr/bin/nm-applet) &
(~/.scripts/connect_bt.sh) &
echo "Sucess loading startup"