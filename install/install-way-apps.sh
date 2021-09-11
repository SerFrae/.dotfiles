#!/bin/sh

sudo pacman -S archlinux-keyring

sudo pacman -S alacritty alsa-utils bluez bluez-utils cargo clang cmake exa fd fuse fzf github-cli grim interception-tools interception-dual-function-keys jq libnotify mako mpv mutt neovim npm openssh pipewire python python-pip pulseaudio ripgrep rsync rustup sd slurp sway swaybg swayidle swaylock texlive-core tmux ttf-font-awesome ttf-jetbrains-mono ttf-nerd-fonts-symbols unrar unzip waybar wf-recorder wget xdg-desktop-portal-wlr xdg-user-dirs zip zsh zsh-syntax-highlighting zathura zathura-pdf-mupdf zsh-autosuggestions

# Install Rust
rustup install nightly
rustup default nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
cargo install wasm-pack
cargo install cargo-outdated

# Install ZPRS
"$DOTFILES/install/install-zprs.sh"

# Install yay
git clone "https://aur.archlinux.org/yay.git" "$XDG_DATA_HOME/yay"
cd "$XDG_DATA_HOME/yay"
makepkg -si

# Install AUR packages
yay -S brave-nightly-bin autojump-rs urlview

# Install PIP packages
pip install --user --upgrade pynvim

# Install NPM Packages
npm install -g yarn
npm install -g typescript

# Change shell
chsh -s /usr/bin/zsh
chsh -s /bin/zsh

zsh
