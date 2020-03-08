#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}


(run $HOME/.scripts/system-startup.sh) &
(sleep 2; run $HOME/.config/polybar/launch.sh) &

#sleep 4; run xmobar &

#Set your native resolution IF it does not exist in xrandr
#More info in the script
#run $HOME/.xmonad/scripts/set-screen-resolution-in-virtualbox.sh

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output eDP1 --primary --mode 3240x2160 --pos 0x0 --rotate normal --output DP1 --mode 2560x1449+3240+0 --rotate normal --output HDMI1 --off --output VIRTUAL1 --off
#xrandr --output eDP1 --primary --mode 3240x2160 --pos 0x0 --rotate normal --output DP1 --mode 2560x1440 --pos 3240x360 --rotate normal --output HDMI1 --off --output VIRTUAL1 --off
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off



#change your keyboard if you need it
#setxkbmap -layout be

#cursor active at boot
#xsetroot -cursor_name left_ptr &

#Some ways to set your wallpaper besides variety or nitrogen
#feh --bg-scale $HOME/.xmonad/matrix_code-wallpaper-3000x2000.jpg &
#start the conky to learn the shortcuts
#(conky -c $HOME/.xmonad/scripts/system-overview) &

#starting utility applications at boot time
#run variety &
#run nm-applet &
#run pamac-tray &
#run xfce4-power-manager &
#numlockx on &
#blueberry-tray &
#compton --config $HOME/.xmonad/scripts/compton.conf &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &

#starting user applications at boot time
#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run spotify &
#run atom &
#run volumeicon &

#run telegram-desktop &
#run discord &
#run dropbox &
#run "insync start" &
#run "ckb-next -b" &

#(sleep 20; sudo mount -a) &
