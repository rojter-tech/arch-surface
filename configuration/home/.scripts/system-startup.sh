#!/bin/bash
feh --bg-scale ~/.xmonad/bg/code-coding_3840x2400.jpg
xrdb -load ~/.Xresources
(~/.screenlayout/1920x1080/top/top_external.sh &)
(~/.scripts/connect_bt.sh &)
(conky &)
setxkbmap -option 'grp:alt_shift_toggle' -layout us,se -variant qwerty
numlockx on
echo "Sucess loading startup"