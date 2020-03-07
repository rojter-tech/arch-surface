#!/bin/bash
HWMON_PATH=/sys/devices/platform/coretemp.0/hwmon/hwmon[0-9]
sudo mkdir -p /hwmon
sudo ln -sf $HWMON_PATH/temp1_input /hwmon/cpu0
sudo ln -sf $HWMON_PATH/temp2_input /hwmon/cpu1
sudo ln -sf $HWMON_PATH/temp3_input /hwmon/cpu2
sudo ln -sf $HWMON_PATH/temp4_input /hwmon/cpu3
sudo ln -sf $HWMON_PATH/temp5_input /hwmon/cpu4
