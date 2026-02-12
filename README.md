# 🏠 Dotfiles

My Arch Linux + Hyprland dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Install

```bash
git clone https://github.com/simon-escano/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh                    # base setup
./install.sh --nvidia           # with NVIDIA support
./install.sh --btrfs            # with btrfs tools
./install.sh --grub             # use GRUB instead of systemd-boot
./install.sh --nvidia --btrfs   # combine flags
```

## Structure

Each top-level directory is a **stow package** that mirrors `$HOME`:

| Package | Contents |
|---------|----------|
| `zsh` | `.zshrc`, `.zprofile`, `.p10k.zsh` |
| `hypr` | Hyprland, hypridle, hyprlock, hyprsunset |
| `waybar` | Status bar config + styles |
| `kitty` | Terminal emulator |
| `swaync` | Notification center |
| `walker` | App launcher |
| `yazi` | File manager |
| `nvim` | Neovim (LazyVim) |
| `btop` | System monitor |
| `theme-colors` | Theme color schemes |
| `fontconfig` | Font configuration |
| `gtk` | GTK 2/3/4 themes |
| `qt` | Qt5/Qt6 theming |
| `xdg-portal` | Desktop portal + file chooser |
| `xsettingsd` | X settings daemon |
| `nwg-look` | GTK settings manager |
| `fcitx5` | Japanese input method |
| `micro` | Micro editor |
| `scripts` | Custom scripts (theming, dotfiles management) |
| `applications` | Custom `.desktop` files (PWAs) |
| `systemd` | User systemd services |
| `vivaldi` | Vivaldi custom CSS + exported settings |

## Scripts

| Script | Description |
|--------|-------------|
| `dotsync` | Sync dotfiles to GitHub (updates pkg lists, exports Vivaldi, commits, pushes) |
| `dotadd <path>` | Add a new config to dotfiles interactively |
| `dotfiles-check` | Login reminder for unsynced changes (local + remote) |
| `dotfiles-watch` | Watches `.config/` for new apps, prompts to add |
| `vivaldi-export` | Export Vivaldi UI settings (toolbars, flags, themes) |
| `vivaldi-import` | Import Vivaldi settings into a fresh install |

## Monitors

`hypr/.config/hypr/hyprland/monitors.conf` contains a generic placeholder. Edit per-device:

```conf
# Desktop
monitor = DP-1, 1920x1080@144, 0x0, 1

# Laptop
monitor = eDP-1, 1920x1080@60, 0x0, 1
```

## Packages

Package lists in `meta/`:
- `pkglist.txt` — official repo packages (`pacman -Qqen`)
- `aurlist.txt` — AUR packages (`pacman -Qqem`)
