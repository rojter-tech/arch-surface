#!/bin/bash
grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#autologin-user=/autologin-user=dreuter/g' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#autologin-session=/autologin-session=i3/g' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf && \
grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf