# niri-dots

A comprehensive dotfiles repository for setting up an integrated Niri desktop environment on Arch Linux systems.

**niri-dots** provides configuration files, automation scripts, and installation guides to streamline the deployment of a modern, productivity-focused Niri-based desktop environment with complementary applications and utilities.

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Quick Start](#quick-start)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Package Installation](#package-installation)
  - [Dotfiles Deployment](#dotfiles-deployment)
- [Component Configuration](#component-configuration)
  - [Niri](#niri)
  - [Waybar](#waybar)
  - [Rofi](#rofi)
- [Automation Scripts](#automation-scripts)
- [Post-Installation Setup](#post-installation-setup)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [License](#license)

---

## Overview

**Niri** is a modern Wayland compositor designed for productivity. This repository provides a complete integration setup that includes:

- **Niri Compositor**: The core window manager
- **Waybar**: Status bar with system information and quick actions
- **Rofi**: Application launcher and window switcher
- **Automation Scripts**: Tools to streamline configuration management
- **System Integration**: Utilities for system monitoring, file management, and development tools

The configurations are designed to work seamlessly together, providing a cohesive desktop experience optimized for productivity and usability.

---

## Repository Structure

```
niri-dots/
├── README.md                      # This file
├── LICENSE                        # MIT License
├── install-packages.sh            # Package installation script
│
├── niri/                          # Niri compositor configuration
│   └── .config/
│       └── niri/
│           └── config.kdl         # Main Niri configuration
│
├── waybar/                        # Waybar status bar configuration
│   └── .config/
│       ├── waybar/
│       │   ├── config.jsonc       # Waybar modules and layout
│       │   └── style.css          # Waybar styling
│
├── rofi/                          # Rofi launcher configuration
│   └── .config/
│       └── rofi/
│           ├── config.rasi        # Rofi settings and keybindings
│           └── [theme files]      # Color schemes and themes
│
└── automation/                    # Automation and helper scripts
    └── .local/
        └── bin/
            └── launch-waybar.sh   # Waybar auto-reload script
```

---

## Quick Start

For experienced users, here's the minimal setup:

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/niri-dots.git
cd niri-dots

# 2. Install required packages
sudo bash install-packages.sh

# 3. Deploy configuration files
# Using GNU Stow (recommended):
stow niri waybar rofi automation

# 4. Start Niri
# Log out and select Niri as your session, or run:
niri
```

---

## Installation

### Prerequisites

- **Distribution**: Arch Linux or Arch-based distribution (Manjaro, EndeavourOS, etc.)
- **AUR Helper**: `paru` or `yay` (for AUR package installation)
- **Base System**: Updated system with essential build tools
- **Display Server**: Wayland-capable GPU drivers

#### Checking Prerequisites

```bash
# Verify Arch-based system
cat /etc/os-release

# Check for paru or yay
which paru
which yay

# Verify GPU drivers are installed
# NVIDIA users should have nvidia-open or nvidia drivers
# AMD users should have mesa drivers
# Intel users should have mesa drivers
```

### Package Installation

The `install-packages.sh` script installs all dependencies and recommended tools:

```bash
sudo bash install-packages.sh
```

**What gets installed:**

- **Desktop Environment**: Niri, Waybar, Rofi, XWayland satellite
- **System Tools**: NetworkManager, file managers, system monitors
- **Terminal & Shell**: Kitty terminal, Starship prompt, Zoxide
- **Development**: Neovim, Zed editor, Git, GitHub CLI, Go
- **CLI Utilities**: eza, fd, fzf, ripgrep, delta, lazygit
- **System Utilities**: Docker, Snapper, Flatpak, Gnome Keyring
- **Multimedia**: KDEnlive, OBS Studio, Steam, Proton
- **Fonts & Input**: Japanese input (fcitx5-mozc), Nerd Fonts

**Note**: Some packages are installed from the AUR. Review the script before running, especially if you prefer to use `yay` instead of `paru`.

### Dotfiles Deployment

#### Option 1: Using GNU Stow (Recommended)

GNU Stow symlinks configuration files to your home directory, making updates simple:

```bash
# Install stow if not already installed
sudo pacman -S stow

# Deploy all configurations
cd niri-dots
stow niri waybar rofi automation

# Deploy individual components
stow niri          # Only Niri config
stow waybar        # Only Waybar config
stow rofi          # Only Rofi config
stow automation    # Only automation scripts
```

#### Option 2: Manual Deployment

```bash
# Copy configuration files to home directory
mkdir -p ~/.config
cp -r niri/.config/niri ~/.config/
cp -r waybar/.config/waybar ~/.config/
cp -r rofi/.config/rofi ~/.config/
mkdir -p ~/.local/bin
cp automation/.local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*
```

---

## Component Configuration

### Niri

Niri is the Wayland compositor and window manager at the heart of this setup.

**Configuration File**: `~/.config/niri/config.kdl`

**Key Features**:

- Tiling and floating window layouts
- Workspace management
- Custom keybindings
- Monitor and resolution settings
- Animation configuration

**Getting Started**:

1. Review the default configuration in this repository
2. Customize keybindings to match your preferences
3. Adjust layout rules for specific applications
4. Configure monitors if using multiple displays

**Documentation**: [Niri GitHub Wiki](https://github.com/YarikSwitdan/niri/wiki)

### Waybar

Waybar displays system information and provides quick access to common functions.

**Configuration Files**:

- `~/.config/waybar/config.jsonc` - Modules and layout
- `~/.config/waybar/style.css` - Visual styling

#### Waybar Auto-Reload

The included `launch-waybar.sh` script automatically restarts Waybar when configuration changes are detected, eliminating the need for manual restarts.

**Setup**:

```bash
# Ensure the script is executable
chmod +x ~/.local/bin/launch-waybar.sh
```

**Starting Waybar with Auto-Reload**:

```bash
nohup ~/.local/bin/launch-waybar.sh &
```

The `nohup` command allows the script to continue running after closing your terminal. Output logs are written to `nohup.out`.

**Monitored Files**:

- `~/.config/waybar/config.jsonc`
- `~/.config/waybar/style.css`

When either file is modified, Waybar automatically:

1. Detects the change
2. Stops the running Waybar process
3. Starts Waybar with updated configuration

**Stopping the Script**:

```bash
killall launch-waybar.sh
```

**Requirements**:

- `gui-apps/waybar` - Status bar
- `sys-apps/inotify-tools` - File monitoring

**Documentation**: [Waybar GitHub](https://github.com/Alexays/Waybar)

### Rofi

Rofi serves as the application launcher, window switcher, and general-purpose menu system.

**Configuration File**: `~/.config/rofi/config.rasi`

**Key Features**:

- Application launching
- Window switching
- SSH connections
- Script execution
- Custom themes

**Usage**:

```bash
# Launch Rofi (typically bound to a keybinding in Niri)
rofi -show drun        # Application launcher
rofi -show window      # Window switcher
rofi -show ssh         # SSH launcher
```

**Customization**:

Edit `~/.config/rofi/config.rasi` to customize:

- Color schemes
- Font and sizing
- Sorting and filtering behavior
- Custom keybindings

**Documentation**: [Rofi GitHub](https://github.com/davatorium/rofi)

---

## Automation Scripts

### launch-waybar.sh

Automatically manages Waybar configuration reloading.

**Location**: `~/.local/bin/launch-waybar.sh`

**Source**: Based on the [Gentoo Wiki Waybar Configuration Guide](https://wiki.gentoo.org/wiki/Waybar)

**Usage**:

```bash
# Run in background
nohup ~/.local/bin/launch-waybar.sh &

# Stop the script
killall launch-waybar.sh
```

**How it Works**:

The script continuously monitors your Waybar configuration files. When changes are detected:

- The current Waybar process is stopped
- Waybar is restarted with the new configuration
- Changes take effect immediately

This is more convenient than manually restarting Waybar after each configuration edit.

---

## Post-Installation Setup

After deploying configurations, perform these additional setup steps:

### 1. Start Niri

```bash
# Option A: Through login manager (recommended)
# Log out and select "Niri" as your session before logging in

# Option B: From terminal
niri
```

### 2. Configure Displays (Multi-Monitor Setup)

Edit `~/.config/niri/config.kdl` to specify display settings:

```kdl
output "HDMI-1" {
    mode "1920x1080@60"
    position x=0 y=0
}

output "DP-1" {
    mode "2560x1440@60"
    position x=1920 y=0
}
```

### 3. Set Up Waybar Autostart

Add to your Niri configuration to start Waybar automatically:

```kdl
spawn-at-startup "waybar"
```

Or use the auto-reload script:

```kdl
spawn-at-startup "nohup ~/.local/bin/launch-waybar.sh &"
```

### 4. Configure Keyboard Layout

If using non-US keyboard layouts, configure in `~/.config/niri/config.kdl`:

```kdl
input {
    keyboard {
        xkb {
            layout "us"
            # layout "jp"  # For Japanese
            # layout "de"  # For German
        }
    }
}
```

### 5. Set Up Japanese Input (Optional)

If you installed fcitx5-mozc and want Japanese input:

```bash
# Configure environment variables
echo 'export GTK_IM_MODULE=fcitx' >> ~/.bashrc
echo 'export QT_IM_MODULE=fcitx' >> ~/.bashrc
echo 'export XMODIFIERS=@im=fcitx' >> ~/.bashrc

# Start fcitx5 in Niri config
spawn-at-startup "fcitx5"
```

### 6. Customize Niri Keybindings

Edit keybindings in `~/.config/niri/config.kdl`. Example:

```kdl
binds {
    "Mod+q" = close-window;
    "Mod+e" = spawn "rofi" "-show" "drun";
    "Mod+Tab" = spawn "rofi" "-show" "window";
}
```

---

## Customization

### Changing Color Schemes

**Waybar Colors**: Edit `~/.config/waybar/style.css`

```css
* {
  background: #1e1e2e;
  foreground: #cdd6f4;
}

#workspaces button.active {
  background: #a6e3a1;
  color: #1e1e2e;
}
```

**Rofi Theme**: Edit `~/.config/rofi/config.rasi` or create a custom theme file

### Adding Custom Applications to Rofi

Create a `.desktop` file in `~/.local/share/applications/` or system-wide in `/usr/share/applications/`

### Adjusting Waybar Modules

Edit `~/.config/waybar/config.jsonc` to add, remove, or reorder modules:

```json
"modules-left": ["sway/workspaces", "sway/mode"],
"modules-center": ["clock"],
"modules-right": ["pulseaudio", "network", "cpu", "battery"]
```

### Creating a Custom Niri Workspace Layout

Add workspace rules to `~/.config/niri/config.kdl`:

```kdl
workspace-switch-animation "to-side" {
    duration-ms 250
    curve "ease-out-cubic"
}
```

---

## Troubleshooting

### Waybar Not Showing

```bash
# Check if Waybar is running
pgrep waybar

# Start Waybar manually
waybar

# Check logs
tail -f nohup.out  # If using launch-waybar.sh
```

### Rofi Not Launching

```bash
# Verify Rofi is installed
which rofi

# Test Rofi directly
rofi -show drun

# Check configuration syntax
rofi -config ~/.config/rofi/config.rasi -show drun
```

### Niri Crashes or Won't Start

```bash
# Check Niri logs
journalctl -u niri -n 50

# Verify configuration syntax
niri validate-config

# Try with minimal configuration (backup your config first)
mv ~/.config/niri/config.kdl ~/.config/niri/config.kdl.bak
niri  # Will use default configuration
```

### GPU Drivers Not Recognized

```bash
# Check installed drivers
glxinfo | grep "OpenGL vendor"

# For NVIDIA users
nvidia-smi

# For AMD users
vulkaninfo | grep GPU

# Install appropriate drivers
sudo pacman -S nvidia          # NVIDIA
sudo pacman -S mesa            # AMD/Intel
```

### Input Method Issues

```bash
# Restart fcitx5
killall fcitx5
fcitx5 &

# Check fcitx5 status
fcitx5-diagnose
```

---

## Contributing

Contributions are welcome! If you have improvements to configurations or scripts:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request with a clear description

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

**Attribution**: The `launch-waybar.sh` script is based on content from the [Gentoo Wiki Waybar Configuration Guide](https://wiki.gentoo.org/wiki/Waybar), which is licensed under CC-BY-SA-4.0. © 2001–2025 Gentoo Authors.

---

## Acknowledgments

This project was developed by the project maintainer with assistance from **GitHub Copilot**, an AI-powered code completion and generation tool. The project management, architectural decisions, and overall structure have been designed and planned by the project manager. GitHub Copilot has specifically assisted with:

- Code completion and refinement
- Small-scale processing and implementation details
- Documentation content refinement and organization
- Commit message composition

All work assisted by AI has undergone thorough review, modification, and validation by the project maintainer. The project maintainer maintains complete control over the project's direction, quality standards, and technical decisions. This collaboration represents a pragmatic approach to modern development, where AI tools enhance productivity while the human maintainer retains full responsibility for the final product's accuracy, completeness, and quality assurance.

---

## Resources & Documentation

- [Niri GitHub Repository](https://github.com/YarikSwitdan/niri)
- [Niri Wiki & Documentation](https://github.com/YarikSwitdan/niri/wiki)
- [Waybar GitHub](https://github.com/Alexays/Waybar)
- [Rofi GitHub](https://github.com/davatorium/rofi)
- [Arch Linux Wiki](https://wiki.archlinux.org/)
- [Wayland Documentation](https://wayland.freedesktop.org/)

---

## Support

For issues or questions:

1. Check the [Troubleshooting](#troubleshooting) section
2. Review component documentation links above
3. Open an issue on GitHub with detailed information about your setup and the problem
