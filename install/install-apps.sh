#!/bin/sh

# Update keyring
sudo pacman -S archlinux-keyring

# Install packages
sudo pacman -S alacritty alsa-utils bluez bluez-utils bspwm cargo clang cmake dunst exa fd feh fzf libnotify maim mutt neovim newsboat npm openssh picom python python-pip pulseaudio qutebrowser ripgrep rofi rustup rust-analyzer sxhkd tmux texlive-core ttf-font-awesome ttf-jetbrains-mono ttf-nerd-fonts-symbols unzip weechat wget xcape xclip xdg-user-dirs xorg xorg-xinit xsel zsh zsh-syntax-highlighting zsh-autosuggestions

# Install Rust
rustup install nightly
rustup default nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
cargo install wasm-pack
cargo install cargo-outdated

# Install PIP packages
pip install --user --upgrade pynvim

# Install NPM Packages
npm install -g yarn
npm install -g typescript

# Install yay
mkdir -p $XDG_CONFIG_HOME/aur
cd $XDG_CONFIG_HOME/aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install ZPRS
"$DOTFILES/install/install-zprs.sh"

# Change shell
chsh -s /usr/bin/zsh
chsh -s /bin/zsh

# Install AUR packages
yay -S polybar brave-nightly-bin betterlockscreen autojump-rs urlview wee-slack weechat-notify-send 
