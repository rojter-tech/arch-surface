#!/bin/bash
sudo pacman -Syyuu --noconfirm --needed
sudo pacman -S p7zip unzip docker gvim git rsync \
bash-completion wget which reflector --noconfirm --needed
reflector --verbose --latest 200 --number 10 --sort rate --save /etc/pacman.d/mirrorlist
mv /usr/bin/vi /usr/bin/vi.bak
cp /usr/bin/vim /usr/bin/vi
systemctl enable docker
groupadd -r autologin
groupadd -r bumblebee
useradd -m -g users -G wheel,storage,power,docker,autologin,audio,bumblebee \
-s /bin/bash dreuter
passwd dreuter
usermod -a -G wheel,storage,power,docker,autologin,audio,bumblebee dreuter
vim /etc/sudoers
#change %wheel ALL=(ALL) NOPASSWD: ALL
su dreuter
