#!/bin/bash
pacstrap /mnt base base-devel linux linux-firmware openssh dhcpcd iw wpa_supplicant networkmanager dialog terminus-font 
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime 
ls -la /etc/localtime
hwclock —-systohc
mv /etc/locale.gen /etc/locale.gen.bak
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen
localectl set-keymap --no-convert us
echo "KEYMAP=us" > /etc/vconsole.conf
echo "FONT=ter-m32n" >> /etc/vconsole.conf
echo "rOjterArchSurface" > /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "127.0.1.1	rojterarchsurface.local	rojterarchsurface" >> /etc/hosts
systemctl enable sshd.service
passwd
exit
umount /mnt/home
umount /mnt
#telinit 6
