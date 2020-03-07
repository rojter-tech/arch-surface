#!/bin/bash
rsync -av * ~/.config/i3/
sudo rsync -av i3status.conf /etc/i3status.conf
