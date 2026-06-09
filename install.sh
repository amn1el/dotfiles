#!/usr/bin/env bash

# ---------------------------------------------------------
# Color palette
# ---------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${BLUE}[*] $1${NC}"; }
success() { echo -e "${GREEN}[+] $1${NC}"; }
error() { echo -e "${RED}[x] $1${NC}"; }
warning() { echo -e "${YELLOW}[!] $1${NC}"; }

# ---------------------------------------------------------
# Initial confirmation
# ---------------------------------------------------------
clear
info "Starting your CachyOS environment setup..."
read -p "This script will update the system, install packages, and overwrite configurations in ~/.config. Continue? [Y/n] " response
response=${response:-Y}

if [[ ! $response =~ ^[Yy]$ ]]; then
    warning "Installation aborted by the user."
    exit 0
fi

# ---------------------------------------------------------
# Install packages (Pacman)
# ---------------------------------------------------------
info "Updating the system and installing packages from official repositories..."
sudo pacman -Syu --noconfirm --needed \
    base-devel git protobuf go nodejs bun rustup \
    nautilus fish alacritty adw-gtk-theme fastfetch \
    steam gamemode libappimage \
    ttf-hack-nerd ttf-meslo-nerd ttf-jetbrains-mono ttf-jetbrains-mono-nerd
success "Base packages installed."

# Configure default Rust toolchain
info "Configuring Rustup (stable toolchain)..."
rustup default stable &> /dev/null
success "Rustup configured."

# ---------------------------------------------------------
# Install Paru (if not present) and AUR packages
# ---------------------------------------------------------
if ! command -v paru &> /dev/null; then
    warning "Paru is not installed. Installing Paru..."
    if ! sudo pacman -S --noconfirm --needed paru; then
        info "Building Paru from AUR..."
        git clone https://aur.archlinux.org/paru.git /tmp/paru
        cd /tmp/paru || exit
        makepkg -si --noconfirm
        cd - || exit
        rm -rf /tmp/paru
    fi
    success "Paru installed successfully."
else
    success "Paru is already installed."
fi

info "Installing packages from AUR using Paru..."
paru -S --noconfirm --needed brave-bin gearlever spotify visual-studio-code-bin wrk noctalia-shell
success "AUR packages installed."

# ---------------------------------------------------------
# Deploy Dotfiles (Symlinks or Direct Copy)
# ---------------------------------------------------------
info "Preparing to deploy configurations..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"
WALLPAPERS_DIR="$DOTFILES_DIR/home/wallpapers"

mkdir -p "$HOME/.config"

echo ""
info "Choose how you want to deploy your configuration files:"
echo "  [S] Symlink - Creates shortcuts (Changes in ~/.config update your repo automatically)"
echo "  [C] Copy    - Copies files directly (Independent snapshot, won't affect your repo)"
read -p "Select deployment method [S/c]: " deploy_choice
deploy_choice=${deploy_choice:-S}
echo ""

for app in alacritty fastfetch fish niri noctalia; do
    if [ -d "$CONFIG_DIR/$app" ]; then
        if [ -L "$HOME/.config/$app" ] || [ -d "$HOME/.config/$app" ]; then
            rm -rf "$HOME/.config/$app"
        fi

        if [[ $deploy_choice =~ ^[Cc]$ ]]; then
            cp -r "$CONFIG_DIR/$app" "$HOME/.config/$app"
            success "Configuration copied directly: $app"
        else
            ln -sfn "$CONFIG_DIR/$app" "$HOME/.config/$app"
            success "Configuration symlinked: $app"
        fi
    else
        warning "Directory not found: $CONFIG_DIR/$app"
    fi
done

if [ -d "$WALLPAPERS_DIR" ]; then
    mkdir -p "$HOME/Pictures/Wallpapers"
    cp -r "$WALLPAPERS_DIR/"* "$HOME/Pictures/wallpapers/"
    success "Wallpapers copied to ~/Pictures/wallpapers"
fi

# ---------------------------------------------------------
# System configurations
# ---------------------------------------------------------
info "Applying final configurations..."

# GTK Theme for GNOME/Noctalia
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
success "Dark GTK theme applied."

# Nautilus Configuration
info "Configuring Nautilus as the default file manager..."
xdg-mime default org.gnome.Nautilus.desktop inode/directory
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'icon-view'
success "Nautilus is now the default file manager."

if [ "$SHELL" != "$(which fish)" ]; then
    info "Changing default shell to Fish..."
    chsh -s "$(which fish)"
    success "Shell changed. Changes will take effect upon logging out and back in."
fi

echo ""
success "All done! Your development environment is set up. A session restart is recommended."