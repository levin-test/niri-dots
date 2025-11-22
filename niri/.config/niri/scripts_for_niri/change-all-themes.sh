#!/bin/bash
set -euo pipefail

WAYBAR_THEMES_DIR="$HOME/niri-dots/waybar/.config/waybar/themes"
KITTY_THEMES_DIR="$HOME/niri-dots/kitty/.config/kitty/themes"

# Get theme list from waybar (base)
THEME_LIST=$(cd "$WAYBAR_THEMES_DIR" && ls -1 *.css 2>/dev/null | sed 's/\.css$//' || echo "")

if [ -z "$THEME_LIST" ]; then
  echo "Error: No theme files found"
  exit 1
fi

# Select theme once with fuzzel
if command -v fuzzel >/dev/null 2>&1; then
  SELECTED_THEME=$(echo "$THEME_LIST" | fuzzel --dmenu --prompt "Select theme: ")

  if [ -z "$SELECTED_THEME" ]; then
    exit 0
  fi
else
  echo "Error: fuzzel is not installed"
  exit 1
fi

# Apply to waybar
~/niri-dots/waybar/.config/waybar/switch-theme.sh "$SELECTED_THEME"

# Check if theme exists in kitty
if [ -f "$KITTY_THEMES_DIR/$SELECTED_THEME.conf" ]; then
  ~/niri-dots/kitty/.config/kitty/scripts/switch-theme.sh "$SELECTED_THEME"
else
  notify-send "Theme '$SELECTED_THEME' not found in Kitty" "Please select a Kitty theme manually" -u normal
  ~/niri-dots/kitty/.config/kitty/scripts/switch-theme.sh
fi
