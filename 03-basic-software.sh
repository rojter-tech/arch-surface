#!/bin/bash
# Logged in to user account from here
cd ~
mkdir sources
# Setting up yay and packer package for aur repository
git clone https://aur.archlinux.org/yay.git ~/sources/yay
cd ~/sources/yay
makepkg -sci
yay --editmenu --nodiffmenu --save
sudo pacman -S wget grep sed bash curl pacman expac jshon --needed --noconfirm
[ -d /tmp/packer ] && rm -rf /tmp/packer
mkdir /tmp/packer
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
mv PKGBUILD\?h\=packer /tmp/packer/PKGBUILD
cd /tmp/packer
makepkg -i /tmp/packer --noconfirm
[ -d /tmp/packer ] && rm -rf /tmp/packer
cd ~ && clear

grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf && \
sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 8 -z -)/g' /etc/makepkg.conf && \
sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j8"/g' /etc/makepkg.conf
grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf

grep "Color" /etc/pacman.conf && \
sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf && \
grep "Color" /etc/pacman.conf

sudo pacman -S nvidia nvidia-utils nvidia-settings xf86-video-intel --noconfirm --needed && \
grep '"yes"' /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf && \
sudo sed -i -e 's/"yes"/"no"/g' /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf && \
grep '"no"' /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf

## From here on it depends on taste and preferences for the moment

# GNOME
sudo pacman -S gnome gnome-extra gnome-shell gdm --noconfirm --needed
sudo systemctl enable gdm.service
yay -S gnome-shell-extensions gnome-shell-extension-dash-to-dock \
  --answerclean N --answeredit N --noconfirm --needed
sudo pacman -R gnome-terminal --noconfirm
yay -S gnome-terminal-transparency --answerclean N --answeredit N --noconfirm --needed

# i3
sudo pacman -S xorg-server xorg-apps xorg-twm \
xorg-xinit mesa i3-gaps i3blocks i3lock i3status numlockx \
xterm rxvt-unicode --noconfirm --needed

# lightdm
sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed
grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#autologin-user=/autologin-user=dreuter/g' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#autologin-session=/autologin-session=i3/g' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf && \
grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf

# Utils

### Fonts
sudo pacman -S noto-fonts ttf-ubuntu-font-family \
ttf-dejavu ttf-liberation ttf-droid \
ttf-inconsolata ttf-roboto terminus-font \
ttf-font-awesome --noconfirm --needed

### Sound and bluetooth
yay -S bluez-firmware --answerclean N --answeredit N --noconfirm --needed
sudo pacman -S bluez bluez-utils bluez-libs \
pulseaudio pulseaudio-bluetooth pulseaudio-equalizer \
pulseaudio-alsa alsa-utils alsa-plugins alsa-lib pavucontrol \
pulseaudio-bluetooth bluez blueberry --noconfirm --needed
sudo systemctl enable bluetooth.service

### Command line utilities
sudo pacman -S rxvt-unicode ranger rofi conky dmenu  \
urxvt-perls perl-anyevent-i3 perl-json-xs --noconfirm --needed
yay -S browsh gksu inxi-git --answerclean N --answeredit N --noconfirm --needed
sudo pacman -S atool highlight elinks mediainfo w3m \
ffmpegthumbnailer mupdf --noconfirm --needed
yay -S urxvt-font-size-git python-pdftotext --answerclean N --answeredit N --noconfirm --needed

### Browsers and code
sudo pacman -S firefox chromium \
  firefox-developer-edition vlc gimp --noconfirm --needed
yay -S visual-studio-code-bin firefox-nightly python-ptvsd \
  --answerclean N --answeredit N --noconfirm --needed

sudo pacman -Syyuu --noconfirm --needed && \
yay -Syyuu --noconfirm --needed

### Fix WiFi
sudo iw dev wlp1s0 set power_save off # Fix only for this session
# Permanent fix
echo "[connection]" | sudo tee -a /etc/NetworkManager/NetworkManager.conf
echo "wifi.powersave = 2" | sudo tee -a /etc/NetworkManager/NetworkManager.conf
echo "[device]" | sudo tee -a /etc/NetworkManager/NetworkManager.conf
echo "wifi.scan-rand-mac-address=false" | sudo tee -a /etc/NetworkManager/NetworkManager.conf
cat /etc/NetworkManager/NetworkManager.conf

### Fix sound
amixer -c 0 sset 'Auto-Mute Mode' Disabled
sudo alsactl store
echo "options snd_mia index=0" | sudo tee -a /etc/modprobe.d/alsa-base.conf
echo "options snd_hda_intel index=1" | sudo tee -a /etc/modprobe.d/alsa-base.conf
cat /etc/modprobe.d/alsa-base.conf

sudo telinit 6
