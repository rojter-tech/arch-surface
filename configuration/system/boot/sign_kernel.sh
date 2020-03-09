#!/bin/bash
#BOOTLOADER_PATH=/boot/efi/EFI/BOOT/grubx64.efi

KERNEL_PATH=/boot/vmlinuz-linux-surface
PRIVKEY_PATH=/boot/efi/keys/arch.priv
CERT_PATH=/boot/efi/keys/arch.pem

sudo echo $KERNEL_PATH
sudo echo $PRIVKEY_PATH
sudo echo $CERT_PATH

sudo sbsign --key $PRIVKEY_PATH \
	    --cert $CERT_PATH \
	    --output $KERNEL_PATH \
	    $KERNEL_PATH


#sudo sbsign --key $PRIVKEY_PATH \
#	    --cert $CERT_PATH \
#	    --output $BOOTLOADER_PATH \
#	    $BOOTLOADER_PATH
