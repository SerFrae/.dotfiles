#!/bin/sh

source ./zsh/zshenv

function dot_install() {
  echo -e "Installing ${1} config"
  $DOTFILES/install/install-${1}.sh
}

dot_install dirs
dot_install zsh
chmod -w $HOME

dot_install alacritty
dot_install ctags
dot_install dfk
dot_install git
dot_install mako
dot_install mutt
dot_install npm
dot_install nvim
dot_install scripts
dot_install sway
dot_install tmux
dot_install urlview
dot_install yarn
dot_install zathura

dot_install way-apps
