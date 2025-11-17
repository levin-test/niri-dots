# niri-dots

Arch系Linuxディストリビューションで統合的なNiriデスクトップ環境を構築するための包括的なドットファイルリポジトリです。Niri、Waybar、Rofi、および自動化スクリプトの設定ファイルと導入ガイドを提供します。

**niri-dots** は、生産性重視のNiriベースのデスクトップ環境をスムーズに導入するための設定ファイル、自動化スクリプト、および詳細なインストール手順を提供します。

---

## 目次

- [概要](#概要)
- [リポジトリ構成](#リポジトリ構成)
- [クイックスタート](#クイックスタート)
- [インストール](#インストール)
  - [前提条件](#前提条件)
  - [パッケージのインストール](#パッケージのインストール)
  - [ドットファイルの配置](#ドットファイルの配置)
- [コンポーネント設定](#コンポーネント設定)
  - [Niri](#niri)
  - [Waybar](#waybar)
  - [Rofi](#rofi)
- [自動化スクリプト](#自動化スクリプト)
  - [launch-waybar.sh](#launch-waybarsh)
  - [f2_launcher](#f2_launcher)
- [インストール後の設定](#インストール後の設定)
- [カスタマイズ](#カスタマイズ)
- [トラブルシューティング](#トラブルシューティング)
- [ライセンス](#ライセンス)

---

## 概要

**Niri** は、生産性を重視して設計された最新のWaylandコンポジタです。このリポジトリは、以下を含む完全な統合セットアップを提供します：

- **Niriコンポジタ**: メインのウィンドウマネージャー
- **Waybar**: システム情報表示とクイックアクションが可能なステータスバー
- **Rofi**: アプリケーションランチャーとウィンドウスイッチャー
- **自動化スクリプト**: 設定管理をスムーズにするツール
- **システム統合**: システム監視、ファイル管理、開発ツール用ユーティリティ

これらの設定は互いにシームレスに機能するよう設計されており、生産性と使いやすさに最適化された統合的なデスクトップ環境を提供します。

---

## リポジトリ構成

```
niri-dots/
├── README.md                      # このファイル（英語版）
├── README.ja.md                   # 日本語版ドキュメント
├── LICENSE                        # MITライセンス
├── install-packages.sh            # パッケージインストールスクリプト
│
├── niri/                          # Niriコンポジタの設定
│   └── .config/
│       └── niri/
│           └── config.kdl         # メインのNiri設定ファイル
│
├── waybar/                        # Waybarステータスバーの設定
│   └── .config/
│       ├── waybar/
│       │   ├── config.jsonc       # Waybarモジュールとレイアウト
│       │   └── style.css          # Waybarのスタイル定義
│
├── rofi/                          # Rofiランチャーの設定
│   └── .config/
│       └── rofi/
│           ├── config.rasi        # Rofiの設定とキーバインディング
│           └── [テーマファイル]    # カラースキームとテーマ
│
└── automation/                    # 自動化スクリプトとヘルパー
    └── .local/
        └── bin/
            └── launch-waybar.sh   # Waybar自動リロードスクリプト
```

---

## クイックスタート

経験者向けの最小限のセットアップ手順です：

```bash
# 1. リポジトリのクローン
git clone https://github.com/yourusername/niri-dots.git
cd niri-dots

# 2. 必要なパッケージのインストール
sudo bash install-packages.sh

# 3. 設定ファイルの配置
# GNU Stowを使用する方法（推奨）：
stow niri waybar rofi automation

# 4. Niriの起動
# ログアウトしてセッション選択画面でNiriを選択するか、以下を実行：
niri
```

---

## インストール

### 前提条件

- **ディストリビューション**: Arch Linux またはArch系ディストリビューション（Manjaro、EndeavourOS等）
- **AURヘルパー**: `paru` または `yay`（AURパッケージのインストール用）
- **基本システム**: 最新の状態に更新されたシステムと必須ビルドツール
- **ディスプレイサーバー**: Wayland対応のGPUドライバ

#### 前提条件の確認

```bash
# Arch系システムの確認
cat /etc/os-release

# paruまたはyayの確認
which paru
which yay

# GPUドライバのインストール状況確認
# NVIDIA ユーザー向け
nvidia-smi

# AMD/Intel ユーザー向け
vulkaninfo | grep GPU
```

### パッケージのインストール

`install-packages.sh` スクリプトがすべての依存パッケージと推奨ツールをインストールします：

```bash
sudo bash install-packages.sh
```

**インストール内容:**

- **デスクトップ環境**: Niri、Waybar、Rofi、XWayland satellite
- **システムツール**: NetworkManager、ファイルマネージャー、システムモニター
- **ターミナルとシェル**: Kitty ターミナル、Starship プロンプト、Zoxide
- **開発ツール**: Neovim、Zed エディタ、Git、GitHub CLI、Go
- **CLIユーティリティ**: eza、fd、fzf、ripgrep、delta、lazygit
- **システムユーティリティ**: Docker、Snapper、Flatpak、Gnome Keyring
- **マルチメディア**: KDEnlive、OBS Studio、Steam、Proton
- **フォント・入力方式**: 日本語入力（fcitx5-mozc）、Nerd Fonts

**注記**: AURからインストールされるパッケージが含まれています。実行前にスクリプトを確認し、必要に応じて `yay` を使用するよう修正してください。

### ドットファイルの配置

#### 方法1: GNU Stowを使用（推奨）

GNU Stowは設定ファイルをホームディレクトリにシンボリックリンクで配置するため、gitでの更新が簡単です：

```bash
# Stowがインストールされていない場合
sudo pacman -S stow

# すべての設定を配置
cd niri-dots
stow niri waybar rofi automation

# 個別のコンポーネントのみ配置
stow niri          # Niriのみ
stow waybar        # Waybarのみ
stow rofi          # Rofiのみ
stow automation    # 自動化スクリプトのみ
```

#### 方法2: 手動配置

```bash
# ホームディレクトリに設定ファイルをコピー
mkdir -p ~/.config
cp -r niri/.config/niri ~/.config/
cp -r waybar/.config/waybar ~/.config/
cp -r rofi/.config/rofi ~/.config/
mkdir -p ~/.local/bin
cp automation/.local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*
```

---

## コンポーネント設定

### Niri

Niriはこのセットアップの中心となるWaylandコンポジタおよびウィンドウマネージャーです。

**設定ファイル**: `~/.config/niri/config.kdl`

**主な機能**:

- タイリングおよびフローティングウィンドウレイアウト
- ワークスペース管理
- カスタムキーバインディング
- モニターと解像度の設定
- アニメーション設定

**はじめ方**:

1. このリポジトリのデフォルト設定を確認
2. キーバインディングを自分の好みに合わせてカスタマイズ
3. 特定のアプリケーション用のレイアウトルールを調整
4. 複数ディスプレイを使用している場合、モニター設定を設定

**ドキュメント**: [Niri GitHub Wiki](https://github.com/YarikSwitdan/niri/wiki)

### Waybar

Waybarはシステム情報を表示し、一般的な機能への素早いアクセスを提供します。

**設定ファイル**:

- `~/.config/waybar/config.jsonc` - モジュールとレイアウト
- `~/.config/waybar/style.css` - ビジュアルスタイル

#### Waybar自動リロード

付属の `launch-waybar.sh` スクリプトは、設定の変更を自動検出してWaybarを再起動し、手動での再起動が不要になります。

**セットアップ**:

```bash
# スクリプトが実行可能であることを確認
chmod +x ~/.local/bin/launch-waybar.sh
```

**Waybarを自動リロード機能付きで起動**:

```bash
nohup ~/.local/bin/launch-waybar.sh &
```

`nohup` コマンドはスクリプトがターミナルを閉じた後も実行を継続することを保証します。ログ出力は `nohup.out` に保存されます。

**監視対象ファイル**:

- `~/.config/waybar/config.jsonc`
- `~/.config/waybar/style.css`

どちらかのファイルが変更されると、Waybarは自動的に：

1. 変更を検出
2. 実行中のWaybarプロセスを停止
3. 更新された設定でWaybarを起動

**スクリプトの停止**:

```bash
killall launch-waybar.sh
```

**必要な依存関係**:

- `gui-apps/waybar` - ステータスバー
- `sys-apps/inotify-tools` - ファイル監視

**ドキュメント**: [Waybar GitHub](https://github.com/Alexays/Waybar)

### Rofi

Rofiはアプリケーションランチャー、ウィンドウスイッチャー、汎用メニューシステムとして機能します。

**設定ファイル**: `~/.config/rofi/config.rasi`

**主な機能**:

- アプリケーションの起動
- ウィンドウの切り替え
- SSHコネクション
- スクリプト実行
- カスタムテーマ

**使用方法**:

```bash
# Rofiを起動（通常はNiriのキーバインディングにバインド）
rofi -show drun        # アプリケーションランチャー
rofi -show window      # ウィンドウスイッチャー
rofi -show ssh         # SSHランチャー
```

**カスタマイズ**:

`~/.config/rofi/config.rasi` を編集して、以下をカスタマイズできます：

- カラースキーム
- フォントとサイズ
- ソートとフィルタリング動作
- カスタムキーバインディング

**ドキュメント**: [Rofi GitHub](https://github.com/davatorium/rofi)

---

## 自動化スクリプト

### launch-waybar.sh

Waybar設定のリロードを自動的に管理します。

**場所**: `~/.local/bin/launch-waybar.sh`

**出所**: [Gentoo Wiki Waybar設定ガイド](https://wiki.gentoo.org/wiki/Waybar)に基づいています

**使用方法**:

```bash
# バックグラウンドで実行
nohup ~/.local/bin/launch-waybar.sh &

# スクリプトの停止
killall launch-waybar.sh
```

**動作原理**:

スクリプトはWaybar設定ファイルを継続的に監視しています。変更が検出されると：

- 現在のWaybarプロセスが停止
- 新しい設定でWaybarが再起動
- 変更が即座に反映

これにより、設定を編集するたびにWaybarを手動で再起動する手間が省けます。

### f2_launcher

Advanced Fuzzy File Launcher with MIME-type support。MIMEタイプに基づいてファイルを開くアプリケーションを選択できます。

**場所**: `~/.config/niri/scripts_for_niri/f2_launcher.sh`

**設定ファイル**: `~/.config/niri/scripts_for_niri/f2_launcher.toml`

**特徴**:

- **MIMEタイプベースのアプリケーション選択**: ファイルのMIMEタイプに応じて複数の候補アプリを設定可能
- **CLIとGUIの自動判別**: `nvim`、`nano`などのCLIアプリは自動的に端末で起動。`zeditor`などのGUIアプリは直接起動
- **ユーザー選択ダイアログ**: Fuzzelで複数候補から選択可能
- **設定ファイルベース**: TOMLフォーマットで容易にカスタマイズ可能

**使用方法**:

```bash
# スクリプトを実行
~/.config/niri/scripts_for_niri/f2_launcher.sh

# Niriのキーバインディングに登録（例）
"Mod+o" = "spawn" "~/.config/niri/scripts_for_niri/f2_launcher.sh";
```

**設定例**:

```toml
[app_metadata]
nvim = "cli"
nano = "cli"
zeditor = "gui"
code = "gui"

[mime_types]
"text/plain" = ["zeditor", "code", "nvim"]
"text/x-shellscript" = ["zeditor", "code", "nano"]
"text/x-python" = ["zeditor", "code", "nvim"]
```

**動作フロー**:

1. `fd`と`fuzzel`でファイルを選択
2. `file`コマンドでMIMEタイプを判定
3. 設定ファイルから該当するアプリケーション候補を取得
4. インストール済みのアプリをフィルタリング
5. Fuzzelで候補を表示（複数の場合）
6. 選択されたアプリがCLIかGUIかを判別
   - **CLI**: 端末（foot/kitty/alacritty/xterm）で起動
   - **GUI**: 直接起動

---

## インストール後の設定

設定をデプロイした後、以下の追加セットアップステップを実施してください：

### 1. Niriの起動

```bash
# オプションA: ログインマネージャー経由（推奨）
# ログアウトしてセッション選択時に「Niri」を選択してからログイン

# オプションB: ターミナルから
niri
```

### 2. ディスプレイの設定（マルチモニターセットアップ）

`~/.config/niri/config.kdl` を編集してディスプレイ設定を指定：

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

### 3. Waybarの自動起動設定

Niri設定ファイルにWaybarの自動起動を追加：

```kdl
spawn-at-startup "waybar"
```

または自動リロードスクリプトを使用：

```kdl
spawn-at-startup "nohup ~/.local/bin/launch-waybar.sh &"
```

### 4. キーボードレイアウトの設定

英語以外のキーボードレイアウトを使用する場合、`~/.config/niri/config.kdl` で設定：

```kdl
input {
    keyboard {
        xkb {
            layout "us"
            # layout "jp"  # 日本語の場合
            # layout "de"  # ドイツ語の場合
        }
    }
}
```

### 5. 日本語入力の設定（オプション）

fcitx5-moczをインストールして日本語入力を使用する場合：

```bash
# 環境変数の設定
echo 'export GTK_IM_MODULE=fcitx' >> ~/.bashrc
echo 'export QT_IM_MODULE=fcitx' >> ~/.bashrc
echo 'export XMODIFIERS=@im=fcitx' >> ~/.bashrc

# Niri設定でfcitx5を起動
spawn-at-startup "fcitx5"
```

### 6. Niriキーバインディングのカスタマイズ

`~/.config/niri/config.kdl` のキーバインディングを編集。例：

```kdl
binds {
    "Mod+q" = close-window;
    "Mod+e" = spawn "rofi" "-show" "drun";
    "Mod+Tab" = spawn "rofi" "-show" "window";
}
```

---

## カスタマイズ

### カラースキームの変更

**Waybarの色**: `~/.config/waybar/style.css` を編集

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

**Rofiテーマ**: `~/.config/rofi/config.rasi` を編集するか、カスタムテーマファイルを作成

### Rofiへのカスタムアプリケーション追加

`~/.local/share/applications/` に `.desktop` ファイルを作成するか、システム全体で `~`.`/usr/share/applications/` に配置

### Waybarモジュールの調整

`~/.config/waybar/config.jsonc` を編集してモジュールの追加、削除、または並び替え：

```json
"modules-left": ["sway/workspaces", "sway/mode"],
"modules-center": ["clock"],
"modules-right": ["pulseaudio", "network", "cpu", "battery"]
```

### Niriのカスタムワークスペースレイアウト作成

`~/.config/niri/config.kdl` にワークスペースルールを追加：

```kdl
workspace-switch-animation "to-side" {
    duration-ms 250
    curve "ease-out-cubic"
}
```

---

## トラブルシューティング

### Waybarが表示されない

```bash
# Waybarが実行中か確認
pgrep waybar

# Waybarを手動起動
waybar

# ログを確認
tail -f nohup.out  # launch-waybar.sh使用時
```

### Rofiが起動しない

```bash
# Rofiがインストールされているか確認
which rofi

# Rofiを直接テスト
rofi -show drun

# 設定ファイルの構文を確認
rofi -config ~/.config/rofi/config.rasi -show drun
```

### Niriがクラッシュするか起動しない

```bash
# Niriのログを確認
journalctl -u niri -n 50

# 設定ファイルの構文を検証
niri validate-config

# 最小限の設定で試す（バックアップを作成してから）
mv ~/.config/niri/config.kdl ~/.config/niri/config.kdl.bak
niri  # デフォルト設定が使用されます
```

### GPUドライバが認識されない

```bash
# インストールされているドライバを確認
glxinfo | grep "OpenGL vendor"

# NVIDIA ユーザー向け
nvidia-smi

# AMD ユーザー向け
vulkaninfo | grep GPU

# 適切なドライバをインストール
sudo pacman -S nvidia          # NVIDIA
sudo pacman -S mesa            # AMD/Intel
```

### 入力方式の問題

```bash
# fcitx5を再起動
killall fcitx5
fcitx5 &

# fcitx5の状態を確認
fcitx5-diagnose
```

---

## 謝辞

このプロジェクトはプロジェクト管理者によって開発され、**GitHub Copilot** の支援を受けています。GitHub Copilot はコード補完と生成を行うAI駆動ツールです。プロジェクト管理、アーキテクチャの決定、全体的な構成はプロジェクト管理者自身によって設計・計画されています。GitHub Copilot が具体的にサポートした作業は以下の通りです：

- コード補完と改善
- 小さな単位での処理と実装詳細
- ドキュメントコンテンツの改善と組織化
- コミットメッセージの作成

AI支援によるすべての成果物は、プロジェクト管理者による徹底的なレビュー、修正、検証を経ています。プロジェクト管理者はプロジェクトの方向性、品質基準、技術的決定に対する完全な統制権を保持しています。このAIツールとの協働は、AI ツールが生産性を向上させる一方で、人間のプロジェクト管理者が最終成果物の正確性、完全性、品質保証に対する全責任を保持する、現代的で実用的な開発アプローチを表しています。

---

## ライセンス

このプロジェクトはMITライセンスの下でライセンスされています。詳細は [LICENSE](LICENSE) ファイルを参照してください。

**帰属表示**: `launch-waybar.sh` スクリプトは CC-BY-SA-4.0 ライセンスの [Gentoo Wiki Waybar設定ガイド](https://wiki.gentoo.org/wiki/Waybar) のコンテンツに基づいています。© 2001–2025 Gentoo Authors

---

## リソースとドキュメント

- [Niri GitHub リポジトリ](https://github.com/YarikSwitdan/niri)
- [Niri Wiki とドキュメント](https://github.com/YarikSwitdan/niri/wiki)
- [Waybar GitHub](https://github.com/Alexays/Waybar)
- [Rofi GitHub](https://github.com/davatorium/rofi)
- [Arch Linux Wiki](https://wiki.archlinux.org/)
- [Wayland ドキュメント](https://wayland.freedesktop.org/)

---

## サポート

問題や質問がある場合：

1. [トラブルシューティング](#トラブルシューティング) セクションを確認
2. 上記のコンポーネントドキュメントリンクを確認
3. 詳細なセットアップ情報と問題の説明を含めて GitHub に Issue を開く
