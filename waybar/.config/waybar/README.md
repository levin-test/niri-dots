# Waybar Theme Switcher

このディレクトリには、Waybarのテーマを簡単に切り替えるための設定が含まれています。

## 📁 ディレクトリ構成

```
waybar/.config/waybar/
├── style.css          # メインCSSファイル（@importのみ）
├── base.css           # テーマ非依存のスタイル定義
├── switch-theme.sh    # テーマ切り替えスクリプト
└── themes/            # テーマ定義ディレクトリ
    ├── catppuccin.css
    ├── gruvbox.css
    ├── nord.css
    ├── original.css
    ├── solarized.css
    └── tokyo-night.css
```

## 🎨 利用可能なテーマ

- **Catppuccin (Mocha)** - 柔らかなパステルカラー
- **Gruvbox** - 温かみのあるレトロカラー
- **Nord** - 北欧風のクールなカラーパレット
- **Original** - オリジナルの配色
- **Solarized Dark** - 目に優しい配色
- **Tokyo Night** - 夜の東京をイメージした配色

## 🚀 使い方

### 方法1: インタラクティブモード（fuzzel使用）

引数なしでスクリプトを実行すると、fuzzelでテーマを選択できます：

```bash
./switch-theme.sh
```

これにより、`themes/` ディレクトリ内のすべてのテーマがfuzzelのdmenuで表示されます。

### 方法2: コマンドライン引数

テーマ名を直接指定して切り替えることもできます：

```bash
./switch-theme.sh gruvbox
./switch-theme.sh nord
./switch-theme.sh catppuccin
./switch-theme.sh tokyo
./switch-theme.sh solarized
./switch-theme.sh original
```

### 方法3: 手動編集

`style.css` の `@import` 行を直接編集することもできます：

```css
@import "themes/gruvbox.css";  /* この行を変更 */
@import "base.css";
```

その後、Waybarを再起動してください：

```bash
pkill -x waybar && waybar &
```

## ➕ 新しいテーマの追加

1. `themes/` ディレクトリに新しい `.css` ファイルを作成
2. 既存のテーマファイルをテンプレートとして使用
3. すべての `@define-color` 変数を定義
4. スクリプトが自動的に新しいテーマを検出します

### 必要な色変数

新しいテーマには以下の変数が必要です：

```css
@define-color global_bg
@define-color global_fg
@define-color tooltip_bg
@define-color tooltip_border
@define-color appmenu_fg
@define-color appmenu_hover_bg
@define-color cpu_fg
@define-color temperature_fg
@define-color disk_fg
@define-color gpu_fg
@define-color memory_fg
@define-color taskbar_btn_bg
@define-color taskbar_btn_border
@define-color taskbar_btn_hover_bg
@define-color taskbar_btn_hover_border
@define-color taskbar_btn_active_bg
@define-color taskbar_btn_active_border
@define-color clock_fg
@define-color tray_hover_bg
@define-color tray_hover_fg
@define-color logout_fg
@define-color logout_bg
@define-color logout_hover_bg
@define-color menuitem_fg
@define-color menuitem_bg
@define-color menuitem_hover_bg
@define-color menuitem_hover_fg
```

## 🔧 依存関係

- **必須**: `sed`, `pkill` (標準的なUnixツール)
- **推奨**: `fuzzel` (インタラクティブモード用)

fuzzelがインストールされていない場合でも、コマンドライン引数でテーマを切り替えることができます。

## 💡 Tips

### キーバインドの設定

お気に入りのキーバインドツール（例: niri, sway, hyprland等）で、テーマ切り替えをキーに割り当てることができます：

```
bind $mod+t exec ~/.config/waybar/switch-theme.sh
```

### ロフィ（rofi）との連携

fuzzelの代わりにrofiを使いたい場合は、スクリプト内の `fuzzel --dmenu` を `rofi -dmenu` に変更してください。

## 📝 技術的な詳細

- GTK互換の `@define-color` を使用して配色を管理
- `@import` ディレクティブでモジュール化された構成
- テーマファイルは完全に独立しており、保守が容易
- スクリプトは標準的なシェルコマンドのみを使用（外部パッケージ不要）

## 🐛 トラブルシューティング

### テーマが適用されない

Waybarを手動で再起動してみてください：

```bash
pkill -x waybar && waybar &
```

### fuzzelが動作しない

fuzzelがインストールされているか確認してください：

```bash
command -v fuzzel
```

インストールされていない場合は、コマンドライン引数でテーマを指定してください。
