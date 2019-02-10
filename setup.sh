#! /bin/bash


# Determine which OS the configurations are going to run in
function get_package_manager() {
  # MAC
  which brew > /dev/null 2>&1 && {
    export PACKAGE_MANAGER="homebrew"
    return;
  }

  # UBUNTU
  which apt > /dev/null 2>&1 && {
    export PACKAGE_MANAGER="apt"
    return;
  }
}

function config_zsh() {
  ZSH_DIR=~/.oh-my-zsh

  if [ -w "$ZSH_DIR" ] ; then
    echo "_____ Updating ZSH _____\n"
    cd "$ZSH_DIR"
    git pull origin master
    cd ~/
  else
    echo "_____ Installing ZSH _____\n"
    brew install zsh
    echo "__ Setting ZSH as default shell __\n"
    chsh -s /usr/local/bin/zsh
    # To do - Ubuntu configs
  fi
}

function config_git() {
  echo "_____ Setting up Git _____"

  git config --global user.email $GIT_EMAIL
  git config --global user.name $GIT_USERNAME
  git config --global core.editor vim
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
}

function config_JS_env() {}

function symlink_dotfiles() {}


set -x -e (
  xcode-select --install

  source .env

  get_package_manager
)

