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
  kdenlive           # Video editing
  obs-studio         # Streaming/recording
  scrcpy             # Android screen mirroring
  steam              # Game platform
  protonup-qt        # Proton/Wine management for gaming
  vivaldi            # Vivaldi browser

  # === Localization & Fonts ===
  fcitx5-mozc        # Japanese input (Mozc)
  ttf-jetbrains-mono-nerd # JetBrains Mono Nerd Font
)

# AUR packages
PKGS_AUR=(
  hyprpaper          # Wallpaper management (AUR)
  swww               # Image switching / wallpaper (AUR)
  nwg-look           # GTK theme settings (AUR)
  visual-studio-code-bin # Visual Studio Code (AUR)
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
