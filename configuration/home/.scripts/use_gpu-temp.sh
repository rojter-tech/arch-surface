#!/bin/bash
sudo surface performance set 4
sudo surface dgpu set on
sudo nvidia-modprobe
sudo systemctl stop bumblebeed.service
sudo systemctl start bumblebeed.service
sleep 2;
optirun glxgears -v
