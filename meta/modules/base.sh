#!/bin/bash
# base.sh — Core setup module (always runs)
# Sourced by install.sh

echo "📦 Base module: packages, stow, shell setup"
echo ""

# --- Install packages ---
if [[ "$SKIP_PACKAGES" != "true" ]]; then
    echo "📋 Installing official packages..."
    if [[ -f "$META_DIR/pkglist.txt" ]]; then
        sudo pacman -S --needed - < "$META_DIR/pkglist.txt"
    fi

    echo ""
    echo "📋 Installing AUR packages (requires yay)..."
    if command -v yay &>/dev/null && [[ -f "$META_DIR/aurlist.txt" ]]; then
        yay -S --needed - < "$META_DIR/aurlist.txt"
    else
        echo "⚠️  yay not found or aurlist.txt missing. Install yay first:"
        echo "   git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
    fi
else
    echo "⏭️  Skipping package installation (--skip-packages)"
fi

echo ""

# --- Stow all packages ---
if [[ "$SKIP_STOW" != "true" ]]; then
    echo "🔗 Stowing dotfiles..."
    cd "$DOTFILES_DIR"

    # Get all stow packages (directories that aren't meta or hidden)
    for pkg in */; do
        pkg="${pkg%/}"
        [[ "$pkg" == "meta" ]] && continue
        [[ "$pkg" == .* ]] && continue

        echo "  → stow $pkg"
        stow "$pkg" 2>&1 || echo "  ⚠️  Failed to stow $pkg"
    done
else
    echo "⏭️  Skipping stow (--skip-stow)"
fi

echo ""

# --- Shell setup ---
echo "🐚 Setting up Oh My Zsh..."
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "  ✅ Oh My Zsh already installed"
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "  → zsh-autosuggestions"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

echo "  → zsh-syntax-highlighting"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

echo "  → fzf-tab"
if [[ ! -d "$ZSH_CUSTOM/plugins/fzf-tab" ]]; then
    git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
fi

echo ""

# --- Make scripts executable ---
echo "🔧 Making scripts executable..."
chmod +x "$HOME/Scripts/"* 2>/dev/null

echo ""

# --- Enable systemd user services ---
echo "🔄 Enabling systemd user services..."
systemctl --user enable elephant.service 2>/dev/null && echo "  ✅ elephant.service" || echo "  ⚠️  elephant.service failed"

echo ""
echo "✅ Base module complete!"
