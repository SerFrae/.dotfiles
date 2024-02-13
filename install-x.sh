#!/bin/sh

# Fucks sake seperate out the dot install from the x install - same for wayland
source ./zsh/zshenv

function dot_install() {
  echo -e "Installing ${1} config"
  $DOTFILES/install/install-${1}.sh
}

function x_install() {
  echo -e  "Installing ${1} config"
  $DOTFILES/install/x/install-${1}.sh
}

#dot_install dirs
#dot_install zsh
chmod -w $HOME

dot_install alacritty
x_install bspwm
#dot_install ctags
#dot_install dfk
x_install dunst
#dot_install git
#dot_install mutt
#dot_install npm
#dot_install nvim
x_install picom
x_install polybar
x_install rofi
#dot_install scripts
x_install sxhkd
#dot_install tmux
#dot_install urlview
x_install X11
#dot_install yarn
#dot_install zathura

x_install x-apps
#dot_install apps
