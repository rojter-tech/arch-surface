#!/bin/sh
SCALENR=2
SCALE_SETTING=$SCALENRx$SCALENR
MAIN_SCREEN_POS=3840x0
EXT_SCREEN_POS=0x0

xrandr \
--output eDP1 --primary --mode 3240x2160 --rotate normal --pos $MAIN_SCREEN_POS \
--output DP1 --mode 1920x1080 --rotate normal --pos $EXT_SCREEN_POS --scale $SCALE_SETTING
