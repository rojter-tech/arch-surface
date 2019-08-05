#!/bin/bash
sudo pacman -Syyuu --noconfirm --needed && \
sudo pacman -S p7zip python unzip pygmentize docker vim htop \
git jq rsync tmux bash-completion keychain mlocate wget \
words lsof which go pciutils lshw pacman-contrib reflector --noconfirm --needed

sudo reflector --verbose --latest 200 --number 10 --sort rate --save /etc/pacman.d/mirrorlist

systemctl enable docker && \
systemctl start docker

groupadd -r autologin && groupadd -r bumblebee && \
useradd -m -g users -G wheel,storage,power,docker,autologin,audio,bumblebee \
-s /bin/bash dreuter && \
passwd dreuter

vim /etc/sudoers
#%wheel ALL=(ALL) NOPASSWD: ALL

su dreuter

mkdir sources && \
cd sources && \
git clone https://aur.archlinux.org/yay.git && \
cd yay && \
makepkg -sci && \
yay --editmenu --nodiffmenu --save

sudo pacman -S wget grep sed bash curl pacman jshon expac --needed --noconfirm
[ -d /tmp/packer ] && rm -rf /tmp/packer
mkdir /tmp/packer
wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=packer
mv PKGBUILD\?h\=packer /tmp/packer/PKGBUILD
cd /tmp/packer
makepkg -i /tmp/packer --noconfirm
[ -d /tmp/packer ] && rm -rf /tmp/packer

grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf && \
sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T 8 -z -)/g' /etc/makepkg.conf && \
sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j8"/g' /etc/makepkg.conf
grep "COMPRESSXZ=(xz" /etc/makepkg.conf && \
grep "#MAKEFLAGS=\"-j" /etc/makepkg.conf

grep "Color" /etc/pacman.conf && \
sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf && \
grep "Color" /etc/pacman.conf

sudo pacman -Syyuu --noconfirm --needed && \
yay -Syyuu --noconfirm --needed

yay -S nvidia-utils-full-beta-all --removemake --answerclean No --answeredit N --noconfirm --needed
sudo pacman -S xf86-video-intel xorg-server xorg-apps xorg-twm xorg-xinit bumblebee mesa \
i3lock i3status numlockx xterm --noconfirm --needed

sh 025-iwcore.sh #script

sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed

sudo pacman -S noto-fonts ttf-ubuntu-font-family \
ttf-dejavu ttf-liberation ttf-droid \
ttf-inconsolata ttf-roboto terminus-font \
ttf-font-awesome --noconfirm --needed

yay -S bluez-firmware --removemake --answerclean No --answeredit N --noconfirm --needed
sudo pacman -S bluez bluez-utils bluez-libs \
pulseaudio pulseaudio-bluetooth pulseaudio-equalizer \
pulseaudio-alsa alsa-utils alsa-plugins alsa-lib pavucontrol \
pulseaudio-bluetooth bluez blueberry --noconfirm --needed

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo systemctl daemon-reload

sudo pacman -S rxvt-unicode ranger rofi conky dmenu  \
urxvt-perls perl-anyevent-i3 perl-json-xs --noconfirm --needed

yay -S browsh gksu inxi-git --removemake --answerclean No --answeredit N --noconfirm --needed
sudo pacman -S atool highlight elinks mediainfo w3m \
ffmpegthumbnailer mupdf --noconfirm --needed

yay -S spotify-dev visual-studio-code-bin python-ptvsd --removemake --answerclean No --answeredit N --noconfirm --needed
sudo pacman -S gimp chromium firefox vlc --noconfirm --needed

yay -S urxvt-font-size-git python-pdftotext --removemake --answerclean No --answeredit N --noconfirm --needed

sudo vim /etc/modprobe.d/alsa-base.conf

#options snd_mia index=0
#options snd_hda_intel index=1

grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#autologin-user=/autologin-user=dreuter/g' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#autologin-session=/autologin-session=i3/g' /etc/lightdm/lightdm.conf && \
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf && \
grep 'autologin-user=\|autologin-session=\|greeter-session=' /etc/lightdm/lightdm.conf

sudo pacman -Syyuu --noconfirm --needed && \
yay -Syyuu --noconfirm --needed

sudo telinit 6

# Testing sound
aplay -l && \
lspci | grep -i audio && \
ls -l /dev/snd/
alsamixer -c 1
speaker-test -c 2

# Testing X Windows
lspci -k | grep -A 2 -E "(VGA|3D)" && \
nvidia-smi && \
nvidia-smi -q -d TEMPERATURE && \
xrandr && \
xrandr --listproviders && \
xdpyinfo | grep dots

# Testing bumblebee
optirun glxgears -info

# Edit ~/.Xresources
xrdb ~/.Xresources

sudo systemctl enable lightdm && \
sudo systemctl start lightdm

#startx