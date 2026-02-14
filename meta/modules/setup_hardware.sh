#!/bin/bash
# setup_hardware.sh — Detects hardware and sets up drivers/env vars
# Sourced by install.sh

echo "📦 Hardware setup module..."

# Default values
CPU_VENDOR=""
GPU_VENDOR=""

# Detect CPU
if grep -q "AuthenticAMD" /proc/cpuinfo; then
    CPU_VENDOR="amd"
elif grep -q "GenuineIntel" /proc/cpuinfo; then
    CPU_VENDOR="intel"
fi

# Detect GPU (simplified check using lspci)
if lspci | grep -i "NVIDIA" &> /dev/null; then
    GPU_VENDOR="nvidia"
elif lspci | grep -i "AMD" | grep -i "VGA" &> /dev/null; then
    GPU_VENDOR="amd"
elif lspci | grep -i "Intel" | grep -i "Integrated Graphics" &> /dev/null; then
    GPU_VENDOR="intel"
fi

# Override with flags if provided
if [[ "$INSTALL_INTEL" == "true" ]]; then
    CPU_VENDOR="intel"
    GPU_VENDOR="intel"
elif [[ "$INSTALL_AMD" == "true" ]]; then
    CPU_VENDOR="amd"
    GPU_VENDOR="amd"
elif [[ "$INSTALL_NVIDIA" == "true" ]]; then
    GPU_VENDOR="nvidia"
    # CPU stays auto-detected or needs another flag, but typically GPU is the main driver issue
fi

echo "  → Detected CPU: $CPU_VENDOR"
echo "  → Detected GPU: $GPU_VENDOR"

# --- Install Packages ---
echo "  Installing hardware-specific packages..."

if [[ "$CPU_VENDOR" == "amd" ]]; then
    if [[ -f "$META_DIR/pkglist_amd.txt" ]]; then
        sudo pacman -S --needed - < "$META_DIR/pkglist_amd.txt"
    fi
elif [[ "$CPU_VENDOR" == "intel" ]]; then
    if [[ -f "$META_DIR/pkglist_intel.txt" ]]; then
        sudo pacman -S --needed - < "$META_DIR/pkglist_intel.txt"
    fi
fi

if [[ "$GPU_VENDOR" == "nvidia" ]]; then
    if [[ -f "$META_DIR/pkglist_nvidia.txt" ]]; then
        sudo pacman -S --needed - < "$META_DIR/pkglist_nvidia.txt"
    fi
    # If users have AMD CPU + Nvidia GPU, the AMD list above covers the CPU microcode
fi

# --- Generate Hyprland Config ---
HARDWARE_CONF="$HOME/.config/hypr/hyprland/hardware.conf"
echo "CONFIG_GENERATED_BY_DOTFILES" > "$HARDWARE_CONF"
echo "# Hardware configuration" >> "$HARDWARE_CONF"

if [[ "$GPU_VENDOR" == "nvidia" ]]; then
    echo "env = LIBVA_DRIVER_NAME,nvidia" >> "$HARDWARE_CONF"
    echo "env = __GLX_VENDOR_LIBRARY_NAME,nvidia" >> "$HARDWARE_CONF"
    echo "env = NVD_BACKEND,direct" >> "$HARDWARE_CONF"
    echo "    Configured for Nvidia"
elif [[ "$GPU_VENDOR" == "intel" ]]; then
    echo "env = LIBVA_DRIVER_NAME,iHD" >> "$HARDWARE_CONF"
    echo "    Configured for Intel"
elif [[ "$GPU_VENDOR" == "amd" ]]; then
    echo "env = LIBVA_DRIVER_NAME,radeonsi" >> "$HARDWARE_CONF"
    echo "env = RADV_PERFTEST,aco" >> "$HARDWARE_CONF"
    echo "    Configured for AMD"
fi

echo ""
