#!/bin/bash
wifi-menu
timedatectl set-ntp true

lsblk
fdisk -l
gdisk
fdisk

mkfs.ext4 /dev/sdX1
mkswap /dev/sdX2
swapon /dev/sdX2

mount /dev/sdX1 /mnt


pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime