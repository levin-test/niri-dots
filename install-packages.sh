#!/bin/sh

# Script to install required packages for Hyprland environment
# Run with sudo privileges if necessary
# Target: Arch Linux (paru)

# Official repository packages
PKGS_OFFICIAL=(
  # === Desktop Environment ===
  niri               # Window manager
  xwayland-satellite # XWayland satellite
  waybar             # Status bar
  rofi               # Launcher
  fuzzel             # Alternative launcher
  networkmanager     # Network management
  nemo               # File manager

  # === Terminal & Shell ===
  kitty              # Terminal emulator
  starship           # Prompt
  zoxide             # Fast directory jumper

  # === Editors & Development ===
  neovim             # Advanced terminal-based text/code editor
  zed                # Modern GUI code editor (fast, collaborative)
  mousepad           # Lightweight graphical text editor (XFCE)
  go                 # Go language

  # === CLI Tools ===
  eza                # Alternative to ls
  fd                 # Fast file search
  fzf                # Command-line fuzzy finder
  ripgrep            # Fast grep
  delta              # git diff viewer
  lazygit            # Terminal git client
  go-yq              # YAML processor


  # === Version Control & APIs ===
  git                # Version control
  github-cli         # GitHub CLI

  # === Dotfiles Management ===
  stow               # Symlink farm manager

  # === System & File Management ===
  xdg-user-dirs      # User directory management
  xdg-utils          # XDG utilities
  docker             # Container management
  snapper            # btrfs snapshot management
  clamav             # Virus scanner
  rclone             # Cloud storage integration
  flatpak            # Universal package manager
  gnome-keyring      # GNOME keyring (credentials manager)
  kvantum            # Kvantum manager (official, recommended for theme configuration)
  kvantum-qt5        # Qt theme engine (Kvantum, official)
  qt5ct              # Qt5 configuration tool
  qt6ct              # Qt6 configuration tool

  # === System Monitoring ===
  fastfetch          # System info display
  htop               # Process viewer
  nvtop              # GPU process viewer
  gdu                # Disk usage analyzer

  # === Multimedia & Applications ===
  mpv                # Media player
  totem              # Media player (GNOME)
  loupe              # Image viewer
  kdenlive           # Video editing
  obs-studio         # Streaming/recording
  scrcpy             # Android screen mirroring
  steam              # Game platform
  protonup-qt        # Proton/Wine management for gaming
  vivaldi            # Vivaldi browser

  # === Localization & Fonts ===
  fcitx5-mozc        # Japanese input (Mozc)
  ttf-jetbrains-mono-nerd # JetBrains Mono Nerd Font
  ttf-firacode-nerd  # FiraCode Nerd Font
  ttf-moralerspace   # MoralerSpace Font
  ttf-rounded-mplus  # Rounded M+ Font
)

# AUR packages
PKGS_AUR=(
  google-chrome      # Google Chrome browser (AUR)
  swww               # Image switching / wallpaper (AUR)
  nwg-look           # GTK theme settings (AUR)
  visual-studio-code-bin # Visual Studio Code (AUR)
)

# Flatpak packages
FLATPAK_PKGS=(

)

echo "Official packages to be installed:"
for pkg in "${PKGS_OFFICIAL[@]}"; do
  echo "  $pkg"
done
echo "--------------------------------"

echo "AUR packages to be installed:"
for pkg in "${PKGS_AUR[@]}"; do
  echo "  $pkg"
done
echo "--------------------------------"

# Install both official and AUR packages using paru
paru -Syu --needed "${PKGS_OFFICIAL[@]}" "${PKGS_AUR[@]}"

echo "================================"
echo "Setting up Docker service..."
echo "================================"

# Enable and start Docker service
if command -v systemctl &> /dev/null; then
  if systemctl is-active --quiet docker; then
    echo "✓ Docker service is already running"
  else
    echo "Enabling and starting Docker service..."
    if sudo systemctl enable docker; then
      echo "✓ Docker service enabled"
      if sudo systemctl start docker; then
        echo "✓ Docker service started successfully"
      else
        echo "✗ Failed to start Docker service"
        exit 1
      fi
    else
      echo "✗ Failed to enable Docker service"
      exit 1
    fi
  fi

  # Check if user is already in docker group
  if [ -n "$SUDO_USER" ]; then
    if groups "$SUDO_USER" 2>/dev/null | grep -q docker; then
      echo "✓ User $SUDO_USER is already in docker group"
    else
      echo "Adding user $SUDO_USER to docker group..."
      if sudo usermod -aG docker "$SUDO_USER" 2>/dev/null; then
        echo "✓ User added to docker group"
        echo "⚠ Note: You need to log out and log back in for group changes to take effect"
      else
        echo "⚠ Could not add user to docker group (may require manual setup)"
      fi
    fi
  fi
else
  echo "⚠ systemctl not found - skipping Docker service setup"
fi

echo "================================"
echo "Installation complete!"
echo "================================"
