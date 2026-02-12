#!/bin/bash
# nvidia.sh — NVIDIA-specific setup
# Sourced by install.sh --nvidia

echo "  Installing NVIDIA packages..."
sudo pacman -S --needed nvidia-open nvidia-utils

echo "  Adding NVIDIA environment variables..."
echo "    Your hypr/hyprland/env.conf should already have NVIDIA vars."
echo "  If not, add these to ~/.config/hypr/hyprland/env.conf:"
echo ""
echo '    env = LIBVA_DRIVER_NAME,nvidia'
echo '    env = __GLX_VENDOR_LIBRARY_NAME,nvidia'
echo '    env = NVD_BACKEND,direct'
echo ""
echo "    NVIDIA module complete!"
