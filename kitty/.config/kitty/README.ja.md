# Kitty ターミナル設定

このディレクトリには、Kitty ターミナルエミュレータの設定ファイルと、動的なテーマ切り替え機能が含まれています。

## 📁 ディレクトリ構成

```
kitty/.config/kitty/
├── README.md                      # 英語版ドキュメント
├── README.ja.md                   # 日本語版ドキュメント
├── THEMES.md                      # テーマ情報と帰属表示
├── kitty.conf                     # メインの Kitty 設定ファイル
├── current-theme.conf             # アクティブテーマへのシンボリックリンク（自動生成、Git管理外）
├── themes/                        # 利用可能なカラースキーム（12+テーマ）
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
└── scripts/                       # テーマ管理ユーティリティ
    ├── switch-theme.sh            # テーマ切り替えスクリプト（初回実行時に自動初期化）
    └── list-themes.sh             # 利用可能なテーマを一覧表示
```

## 🚀 クイックスタート

### テーマの切り替え（初回実行時に自動初期化）

```sh
# インタラクティブモード（Fuzzel推奨）
~/.config/kitty/scripts/switch-theme.sh

# 特定のテーマを直接指定
~/.config/kitty/scripts/switch-theme.sh Earthsong

# 利用可能なテーマを一覧表示（現在のテーマに*マークが付く）
~/.config/kitty/scripts/list-themes.sh

# スクリプト用のシンプルなテーマ一覧
~/.config/kitty/scripts/list-themes.sh --simple
```

**注記**: 初回実行時、`switch-theme.sh` は自動的に `current-theme.conf` を作成し、デフォルトのテーマ（Earthsong）で初期化されます。

## 🎨 動作の仕組み

### Stow との連携したハイブリッドアプローチ

この設定は**ハイブリッドアプローチ**を採用し、シンボリックリンクと Kitty のリモートコントロール機能を組み合わせています：

1. **Stow 管理**: メイン設定ファイルを Stow で管理
   - `kitty.conf` → niri-dots からシンボリックリンク
   - `themes/*.conf` → niri-dots からシンボリックリンク
   - `scripts/*.sh` → niri-dots からシンボリックリンク

2. **動的テーマリンク**: `current-theme.conf` は相対シンボリックリンク
   - スクリプトによって作成（Git 管理外）
   - `./themes/<ThemeName>.conf` を指す
   - シンボリックリンクの連鎖：`current-theme.conf` → `themes/X.conf` → 実ファイル

3. **自動初期化**: 初回実行時に自動的に `current-theme.conf` を作成
   - Stow 後の手動セットアップは不要
   - デフォルトは Earthsong テーマ

4. **リアルタイム更新**: テーマを切り替えた時
   - `current-theme.conf` シンボリックリンクを更新
   - 実行中の Kitty インスタンスにリモートコントロール API で反映
   - 新しいウィンドウ/タブは新しいテーマを自動的に使用

### シンボリックリンクの連鎖が機能する理由

```
~/.config/kitty/current-theme.conf (スクリプトが生成するシンボリックリンク)
    ↓
~/.config/kitty/themes/Earthsong.conf (Stow が作成するシンボリックリンク)
    ↓
~/niri-dots/kitty/.config/kitty/themes/Earthsong.conf (実際のファイル)
```

Linux はこの連鎖を透過的に処理します。Kitty は最終的なファイル内容を読み取ります。

## 📝 メイン設定

`kitty.conf` には以下の設定が含まれています：

- **フォント**: JetBrainsMono Nerd Font Mono（14pt）
- **透明度**: 背景透明度 0.8
- **テーマ**: `include ./current-theme.conf` で動的に読み込み
- **キーバインディング**:
  - `Shift+Ctrl+Return`: 新しいタブを開く
  - `Shift+Ctrl+H`: 前のタブに移動
  - `Shift+Ctrl+L`: 次のタブに移動
- **リモートコントロール**: ライブテーマ切り替えに対応

## 🎨 利用可能なテーマ

以下のテーマが搭載されており、Waybar のテーマコレクションと統一されています：

- **Ayu** - 暗い背景に明るい色のシンプルなテーマ
- **Catppuccin Mocha** - 高い精神を持つ人向けの落ち着いたパステルテーマ
- **Earthsong** - 暖かみのあるアースカラーの配色（デフォルト）
- **Everforest** - 暖かく優しい緑系の配色
- **Flatland** - ミニマリストなフラットデザインインスパイアテーマ
- **Gruvbox Dark** - 暖色系のレトログルーヴ配色
- **Night Owl** - 夜型人間向けに慎重に選んだ色
- **Nord** - 北欧風の北極色パレット
- **Palenight** - Material Design インスパイアのやさしい紫系テーマ
- **Shades of Purple** - 大胆な紫色を使ったプロフェッショナルテーマ
- **Solarized Dark** - マシンと人のための精密カラー
- **Tokyo Night** - 東京の夜にインスパイアされた洗練されたダークテーマ

## 🎯 新しいテーマの追加

1. `themes/` ディレクトリに新しい `.conf` ファイルを作成：

   ```sh
   # テーマファイルのフォーマット例
   cat > themes/MyTheme.conf << EOF
   background            #282420
   foreground            #e5c6a8
   cursor                #f6f6ec
   selection_background  #111417
   color0                #111417
   # ... (color0-color15 で合計16色)
   EOF
   ```

2. Git にコミット：

   ```sh
   git add themes/MyTheme.conf
   git commit -m "Add MyTheme color scheme"
   ```

3. 新しいテーマに切り替え：

   ```sh
   ~/.config/kitty/scripts/switch-theme.sh MyTheme
   ```

### テーマ切り替えの例

```sh
# さまざまなテーマを試す
~/.config/kitty/scripts/switch-theme.sh catppuccin-mocha
~/.config/kitty/scripts/switch-theme.sh tokyo-night
~/.config/kitty/scripts/switch-theme.sh nord
~/.config/kitty/scripts/switch-theme.sh gruvbox-dark
~/.config/kitty/scripts/switch-theme.sh palenight
```

## 🔧 スクリプトの詳細

### `switch-theme.sh`

実行中のインスタンスにテーマを適用します。インタラクティブモードと直接指定モードの両方に対応。

**インタラクティブモード（Fuzzel使用）:**

```sh
~/.config/kitty/scripts/switch-theme.sh
```

**直接指定モード:**

```sh
~/.config/kitty/scripts/switch-theme.sh <theme-name>
```

**機能**:

- 初回実行時に自動初期化（手動セットアップ不要）
- `current-theme.conf` シンボリックリンクを更新
- `kitty @` コマンドを使用してすべての実行中の Kitty インスタンスに適用
- テーマが存在しない場合はエラーを表示
- Fuzzel 統合でインタラクティブに選択可能

### `list-themes.sh`

利用可能なテーマを一覧表示します（現在のテーマに*マークが付く）。

**フォーマット済み出力（デフォルト）:**

```sh
~/.config/kitty/scripts/list-themes.sh
```

出力例：

```
Available themes:

  * Earthsong (current)
    Flatland
    Solarized_Dark_Higher_Contrast
```

**シンプル出力（Fuzzel/dmenu 用）:**

```sh
~/.config/kitty/scripts/list-themes.sh --simple
```

出力例：

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

## 🔍 トラブルシューティング

### 実行中のインスタンスにテーマが反映されない

テーマがすぐに適用されない場合は、以下を試してください：

```sh
# 設定を手動で再読み込み
kitty @ load-config

# または Kitty を再起動
```

### "current-theme.conf: No such file or directory"

スイッチスクリプトを実行すれば自動初期化されます：

```sh
cd ~/.config/kitty
./scripts/switch-theme.sh
```

### 現在のテーマを確認

```sh
readlink ~/.config/kitty/current-theme.conf
# 出力例: ./themes/Earthsong.conf
```

## 🔗 Stow との統合

この設定は GNU Stow とシームレスに動作するように設計されています：

1. **Stow 前**: ファイルは `~/niri-dots/kitty/.config/kitty/` にある
2. **Stow 後**: ファイルは `~/.config/kitty/` にシンボリックリンクされる
3. **生成ファイル**: `current-theme.conf` は初回テーマ切り替え時に自動作成（`.gitignore` で除外）

### Stow コマンド

```sh
# 設定を配置
cd ~/niri-dots
stow kitty

# テーマは初回使用時に自動初期化
~/.config/kitty/scripts/switch-theme.sh

# 設定を削除
cd ~/niri-dots
stow -D kitty
```

### Git 統合

動的に生成される `current-theme.conf` はルートの `.gitignore` ファイルで除外されています：

```gitignore
waybar/.config/waybar/style.css
kitty/.config/kitty/current-theme.conf
```

## 📚 リソース

- [Kitty 公式ドキュメント](https://sw.kovidgoyal.net/kitty/)
- [Kitty リモートコントロール](https://sw.kovidgoyal.net/kitty/remote-control/)
- [Kitty カラーテーマ](https://github.com/dexpota/kitty-themes)

## 🎓 テーマの帰属表示

すべてのテーマの詳細情報、出典、ライセンス、作者については [THEMES.md](./THEMES.md) を参照してください。

主なポイント：

- ほとんどのテーマは公式リポジトリまたは [kovidgoyal/kitty-themes](https://github.com/kovidgoyal/kitty-themes) コレクションから取得
- すべてのテーマのファイルヘッダーに出典/アップストリーム情報を記載
- 2つのテーマ（Palenight、Shades of Purple）は Waybar テーマカラーをベースにしたカスタム改変版
- すべてのテーマは MIT またはMIT互換のオープンソースライセンス

## 📄 ライセンス

この設定は niri-dots リポジトリの一部です。
