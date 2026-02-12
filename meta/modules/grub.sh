#!/bin/bash
# grub.sh — GRUB-specific setup (alternative to systemd-boot)
# Sourced by install.sh --grub

echo "  Installing GRUB..."
sudo pacman -S --needed grub efibootmgr os-prober

echo ""
echo "    To install GRUB (EFI):"
echo "    sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB"
echo "    sudo grub-mkconfig -o /boot/grub/grub.cfg"
echo ""
echo "    If dual-booting, enable os-prober:"
echo "    Uncomment GRUB_DISABLE_OS_PROBER=false in /etc/default/grub"
echo ""
echo "    GRUB module complete!"
