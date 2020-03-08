#!/bin/bash
# Assumes complete partition system mounted and 
# ready, including EFI parition mounted as /boot/efi
pacstrap /mnt base base-devel openssh terminus-font awesome-terminal-fonts dhcpcd iw \
  screenfetch wpa_supplicant networkmanager dialog grub os-prober efibootmgr sbsigntools
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

systemctl enable dhcpcd.service
systemctl enable sshd.service
systemctl enable NetworkManager.service

sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
grep "PermitRootLogin yes" /etc/ssh/sshd_config

mkdir /boot/grub
os-prober
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

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
echo "127.0.0.1    localhost" >> /etc/hosts
echo "127.0.1.1    rojterarchsurface.lo    rojterarchsurface" >> /etc/hosts

passwd
exit

umount /mnt/boot/efi
umount /mnt/home
umount /mnt
telinit 6
