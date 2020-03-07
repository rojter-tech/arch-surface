#!/bin/bash
xrdb -load ~/.Xresources
~/.screenlayout/1920x1080/top/top_external.sh
feh --bg-scale ~/.xmonad/bg/code-coding_3840x2400.jpg
(~/.scripts/connect_bt.sh &)
setxkbmap -option 'grp:alt_shift_toggle' -layout us,se -variant qwerty
numlockx on
conky
echo "Sucess loading startup"