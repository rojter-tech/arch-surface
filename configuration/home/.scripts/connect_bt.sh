#!/bin/bash
DEVICE=28:11:A5:DD:80:23
echo "disconnect $DEVICE" | bluetoothctl
sleep 5;
echo "connect $DEVICE" | bluetoothctl
