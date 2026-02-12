#!/bin/bash
# btrfs.sh — btrfs-specific setup
# Sourced by install.sh --btrfs

echo "  Installing btrfs tools..."
sudo pacman -S --needed btrfs-progs snapper snap-pac grub-btrfs 2>/dev/null || true

echo ""
echo "    btrfs subvolume layout recommendations:"
echo "    @          → /"
echo "    @home      → /home"
echo "    @snapshots → /.snapshots"
echo "    @log       → /var/log"
echo "    @cache     → /var/cache"
echo ""
echo "    To set up snapper:"
echo "    sudo snapper -c root create-config /"
echo "    sudo snapper -c home create-config /home"
echo ""
echo "    btrfs module complete!"
