#!/bin/bash
ls /usr/share/kbd/keymaps/i386/querty
localectl list-keymaps | grep -i us
find /usr/share/kbd/keymaps/ -type f
loadkeys us

wifi-menu
timedatectl set-ntp true

vi /etc/pacman.d/mirrorlist

lsblk
fdisk -l
fdisk
gdisk
# Clean totally formatted install
## EFI partition ##
gdisk /dev/sda
o
n
# Enter partition number
# Enter first sector
+512M
EF00
## Root partition ##
n
# Enter partition number
# Enter first sector
+40G
#
# and so on, make a swap aswell
#vertify
p
#write
w

mkfs.fat -F32 /dev/XXX1
mkfs.ext4 /dev/XXX2
mkswap /dev/XXX3
swapon /dev/XXX3

mount /dev/XXX2 /mnt
mount /dev/XXX1 /mnt/boot

pacstrap /mnt base base-devel openssh iw wpa_supplicant dialog
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime 
ls -la /etc/localtime
hwclock —-systohc

mv /etc/locale.gen /etc/locale.gen.bak
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
cat /etc/locale.gen
cat /etc/locale.conf
locale-gen

locale -a
locale

localectl set-keymap --no-convert us
echo "KEYMAP=us" > /etc/vconsole.conf

echo $HOSTNAME > /etc/hostname

echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	myhostname.localdomain	myhostname" >> /etc/hosts

systemctl enable sshd.service

passwd

exit

umount /mnt/boot
umount /mnt