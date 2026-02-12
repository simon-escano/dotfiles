#!/bin/bash
# install.sh — Bootstrap dotfiles on a fresh Arch install
# Usage: ./install.sh [OPTIONS]
#
# Options:
#   --nvidia         Include NVIDIA-specific setup
#   --btrfs          Include btrfs subvolume/snapshot setup
#   --grub           Use GRUB instead of systemd-boot
#   --systemd-boot   Use systemd-boot (default, no extra action needed)
#   --skip-packages  Skip package installation
#   --skip-stow      Skip stow symlinking
#   --help           Show this help

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
META_DIR="$DOTFILES_DIR/meta"
MODULES_DIR="$META_DIR/modules"

# --- Parse arguments ---
INSTALL_NVIDIA=false
INSTALL_BTRFS=false
INSTALL_GRUB=false
SKIP_PACKAGES=false
SKIP_STOW=false

for arg in "$@"; do
    case "$arg" in
        --nvidia)         INSTALL_NVIDIA=true ;;
        --btrfs)          INSTALL_BTRFS=true ;;
        --grub)           INSTALL_GRUB=true ;;
        --systemd-boot)   ;; # default, no action
        --skip-packages)  SKIP_PACKAGES=true ;;
        --skip-stow)      SKIP_STOW=true ;;
        --help)
            head -10 "$0" | tail -8
            exit 0
            ;;
        *)
            echo "Unknown option: $arg"
            exit 1
            ;;
    esac
done

echo "╔══════════════════════════════════════╗"
echo "║    🏠 Dotfiles Bootstrap Installer   ║"
echo "╚══════════════════════════════════════╝"
echo ""

# --- Base module (always runs) ---
source "$MODULES_DIR/base.sh"

# --- Optional modules ---
if [[ "$INSTALL_NVIDIA" == "true" ]]; then
    echo ""
    echo "🎮 Running NVIDIA module..."
    source "$MODULES_DIR/nvidia.sh"
fi

if [[ "$INSTALL_BTRFS" == "true" ]]; then
    echo ""
    echo "💾 Running btrfs module..."
    source "$MODULES_DIR/btrfs.sh"
fi

if [[ "$INSTALL_GRUB" == "true" ]]; then
    echo ""
    echo "🔧 Running GRUB module..."
    source "$MODULES_DIR/grub.sh"
fi

echo ""
echo "╔══════════════════════════════════════╗"
echo "║    🎉 Setup complete!                ║"
echo "╚══════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Log out and back in (or reboot)"
echo "  2. Run 'p10k configure' if prompt looks wrong"
echo "  3. Launch Vivaldi once, close it, then run 'vivaldi-import'"
echo "  4. Enjoy your setup! 🚀"
