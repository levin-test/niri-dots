#!/bin/bash

# 壁紙ディレクトリを指定（必要に応じて変更）
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# 画像ファイル（jpg, png, jpeg）を検索
selected=$(fd -e jpg -e png -e jpeg . "$WALLPAPER_DIR" | fuzzel --dmenu -w 100 -i -p "Select Wallpaper>")
# 選択された画像があればswwwでセット
if [ -n "$selected" ]; then
    swww img "$selected"
fi
