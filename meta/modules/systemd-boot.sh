#!/bin/bash
# systemd-boot.sh — systemd-boot specific setup
# Sourced by install.sh --systemd-boot (default, usually no extra action needed)

echo "  ℹ️  systemd-boot is the default bootloader."
echo "  If not yet installed:"
echo "    sudo bootctl install"
echo ""
echo "  ℹ️  Loader config: /boot/loader/loader.conf"
echo "  ℹ️  Entry config:  /boot/loader/entries/*.conf"
echo ""
echo "  ✅ systemd-boot module complete!"
