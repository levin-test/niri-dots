# Kitty Configuration

This directory contains the Kitty terminal emulator configuration with dynamic theme switching support.

## 📁 Structure

```
kitty/.config/kitty/
├── kitty.conf              # Main configuration file
├── current-theme.conf      # Symlink to active theme (auto-generated, not in Git)
├── themes/                 # Available color schemes
│   ├── ayu.conf
│   ├── catppuccin-mocha.conf
│   ├── Earthsong.conf
│   ├── everforest.conf
│   ├── Flatland.conf
│   ├── gruvbox-dark.conf
│   ├── night-owl.conf
│   ├── nord.conf
│   ├── palenight.conf
│   ├── shades-of-purple.conf
│   ├── Solarized_Dark_Higher_Contrast.conf
│   └── tokyo-night.conf
└── scripts/                # Theme management utilities
    ├── switch-theme.sh     # Switch themes (auto-initializes on first run)
    └── list-themes.sh      # List available themes
```

## 🚀 Quick Start

### Switching Themes (Auto-initializes on first run)

```sh
# Interactive mode with fuzzel (recommended)
~/.config/kitty/scripts/switch-theme.sh

# Switch to a specific theme
~/.config/kitty/scripts/switch-theme.sh Flantland

# List all available themes (shows current theme marked with *)
~/.config/kitty/scripts/list-themes.sh

# Simple list for scripting
~/.config/kitty/scripts/list-themes.sh --simple
```

**Note:** On first run, `switch-theme.sh` automatically initializes with the default theme (Earthsong).

## 🎨 How It Works

### Hybrid Approach with Stow

This configuration uses a **hybrid approach** combining symlinks and Kitty's remote control:

1. **Stow Management**: Main configuration files are managed by stow
   - `kitty.conf` → symlinked from niri-dots
   - `themes/*.conf` → symlinked from niri-dots
   - `scripts/*.sh` → symlinked from niri-dots

2. **Dynamic Theme Link**: `current-theme.conf` is a relative symlink
   - Created by scripts (not managed by Git)
   - Points to `./themes/<ThemeName>.conf`
   - This creates a symlink chain: `current-theme.conf` → `themes/X.conf` → actual file

3. **Auto-initialization**: First run automatically creates `current-theme.conf`
   - No manual setup required after stow
   - Defaults to Earthsong theme

4. **Live Updates**: When switching themes:
   - Updates the `current-theme.conf` symlink
   - Applies to running Kitty instances via remote control API
   - New Kitty windows/tabs automatically use the new theme

### Why Symlink Chain Works

```
~/.config/kitty/current-theme.conf (script-generated symlink)
    ↓
~/.config/kitty/themes/Earthsong.conf (stow symlink)
    ↓
~/niri-dots/kitty/.config/kitty/themes/Earthsong.conf (actual file)
```

Linux handles this transparently. Kitty reads through the chain to get the final file content.

## 📝 Main Configuration

The `kitty.conf` includes:

- **Font**: JetBrainsMono Nerd Font Mono (14pt)
- **Opacity**: 0.8 background transparency
- **Theme**: Dynamically loaded via `include ./current-theme.conf`
- **Keybindings**:
  - `Shift+Ctrl+Return`: New tab
  - `Shift+Ctrl+H`: Previous tab
  - `Shift+Ctrl+L`: Next tab
- **Remote Control**: Enabled for live theme switching

## 🎨 Available Themes

The following themes are included, matching the waybar theme collection:

- **Ayu** - A simple theme with bright colors on a dark background
- **Catppuccin Mocha** - Soothing pastel theme for the high-spirited
- **Earthsong** - Warm earth-toned color scheme (default)
- **Everforest** - A green based color scheme designed to be warm and soft
- **Flatland** - Minimalist flat design inspired theme
- **Gruvbox Dark** - Retro groove color scheme with warm colors
- **Night Owl** - A theme for night owls with carefully chosen colors
- **Nord** - Arctic, north-bluish color palette
- **Palenight** - A soothing purple themed Material Design inspired scheme
- **Shades of Purple** - Professional theme with bold shades of purple
- **Solarized Dark** - Precision colors for machines and people
- **Tokyo Night** - A clean dark theme inspired by the Tokyo night

## 🎯 Adding New Themes

1. Add a new `.conf` file to the `themes/` directory:

   ```sh
   # Example theme file format
   cat > themes/MyTheme.conf << EOF
   background            #282420
   foreground            #e5c6a8
   cursor                #f6f6ec
   selection_background  #111417
   color0                #111417
   # ... (16 colors total: color0-color15)
   EOF
   ```

2. Commit to Git:

   ```sh
   git add themes/MyTheme.conf
   git commit -m "Add MyTheme color scheme"
   ```

3. Switch to the new theme:

   ```sh
   ~/.config/kitty/scripts/switch-theme.sh MyTheme
   ```

### Quick Theme Switching Examples

```sh
# Try different themes
~/.config/kitty/scripts/switch-theme.sh catppuccin-mocha
~/.config/kitty/scripts/switch-theme.sh tokyo-night
~/.config/kitty/scripts/switch-theme.sh nord
~/.config/kitty/scripts/switch-theme.sh gruvbox-dark
~/.config/kitty/scripts/switch-theme.sh palenight
```

## 🔧 Script Details

### `switch-theme.sh`

Switches the active theme and applies it to running instances. Supports both interactive and direct modes.

**Interactive mode (with fuzzel):**

```sh
./scripts/switch-theme.sh
```

**Direct mode:**

```sh
./scripts/switch-theme.sh <theme-name>
```

Features:

- Auto-initializes on first run (no manual setup needed)
- Updates `current-theme.conf` symlink
- Applies to all running Kitty instances via `kitty @` commands
- Shows error if theme doesn't exist
- Fuzzel integration for interactive selection

### `list-themes.sh`

Lists all available themes with current selection marked.

**Formatted output (default):**

```sh
./scripts/list-themes.sh
```

Output:

```
Available themes:

  * Earthsong (current)
    Flantland
    Solarized_Dark_Higher_Contrast
```

**Simple output (for fuzzel/dmenu):**

```sh
./scripts/list-themes.sh --simple
```

Output:

```
ayu
catppuccin-mocha
Earthsong
everforest
Flatland
gruvbox-dark
night-owl
nord
palenight
shades-of-purple
Solarized_Dark_Higher_Contrast
tokyo-night
```

## 🔍 Troubleshooting

### Theme not applying to running instances

If the theme doesn't apply immediately:

```sh
# Reload config manually
kitty @ load-config

# Or restart Kitty
```

### "current-theme.conf: No such file or directory"

Simply run the switch script (it auto-initializes):

```sh
cd ~/.config/kitty
./scripts/switch-theme.sh
```

### Checking current theme

```sh
readlink ~/.config/kitty/current-theme.conf
# Output: ./themes/Earthsong.conf
```

## 🔗 Stow Integration

This configuration is designed to work seamlessly with GNU Stow:

1. **Before stow**: Files are in `~/niri-dots/kitty/.config/kitty/`
2. **After stow**: Files are symlinked to `~/.config/kitty/`
3. **Generated file**: `current-theme.conf` is auto-created on first theme switch (Git-ignored via root `.gitignore`)

### Stow Commands

```sh
# Apply configuration
cd ~/niri-dots
stow kitty

# Theme is automatically initialized on first use
~/.config/kitty/scripts/switch-theme.sh

# Remove configuration
cd ~/niri-dots
stow -D kitty
```

### Git Integration

The dynamically generated `current-theme.conf` is excluded from Git via the root `.gitignore` file:

```gitignore
waybar/.config/waybar/style.css
kitty/.config/kitty/current-theme.conf
```

## 📚 Resources

- [Kitty Documentation](https://sw.kovidgoyal.net/kitty/)
- [Kitty Remote Control](https://sw.kovidgoyal.net/kitty/remote-control/)
- [Kitty Color Themes](https://github.com/dexpota/kitty-themes)

## 🎓 Theme Attribution

For detailed information about all included themes, their sources, licenses, and authors, please see [THEMES.md](./THEMES.md).

Key points:

- Most themes are sourced from official repositories or the [kovidgoyal/kitty-themes](https://github.com/kovidgoyal/kitty-themes) collection
- All themes include source/upstream information in their file headers
- Two themes (Palenight, Shades of Purple) are custom adaptations based on waybar theme colors
- All themes are licensed under MIT or compatible open-source licenses

## 📄 License

This configuration is part of the niri-dots repository.
