#!/bin/bash
groupadd -r autologin
groupadd -r docker
useradd -m -g users \
  -G wheel,storage,power,docker,autologin,audio \
  -s /bin/bash dreuter

# Add user to wheel group
usermod -a -G wheel,storage,power,docker,autologin,audio dreuter

# Change access to wheel group
grep "# %wheel ALL=(ALL) NOPASSWD: ALL" /etc/sudoers && \
sed -i \
  -e 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' \
  /etc/sudoers && \
grep "%wheel ALL=(ALL) NOPASSWD: ALL" /etc/sudoers

passwd dreuter && su dreuter

sudo pacman -Syyuu p7zip unzip docker gvim \
  git rsync bash-completion wget which \
  reflector --noconfirm --needed
sudo systemctl enable docker

sudo reflector --verbose --latest 200 --number 5 --sort rate --save /etc/pacman.d/mirrorlist
echo 'Server = http://ftp.acc.umu.se/mirror/archlinux/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = https://ftp.acc.umu.se/mirror/archlinux/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = http://archlinux.dynamict.se/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = https://archlinux.dynamict.se/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = http://ftp.lysator.liu.se/pub/archlinux/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = https://ftp.lysator.liu.se/pub/archlinux/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = http://ftp.myrveln.se/pub/linux/archlinux/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = https://ftp.myrveln.se/pub/linux/archlinux/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
echo 'Server = https://mirror.osbeck.com/archlinux/$repo/os/$arch' | sudo tee -a /etc/pacman.d/mirrorlist
sudo pacman -Syyuu
cat /etc/pacman.d/mirrorlist

sudo ln -s /usr/bin/vim /usr/bin/vi

sudo telinit 6
