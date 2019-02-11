#! /bin/bash

COLOR="\033[1;32m"
NO_COLOR="\033[0m"

function config_brew() {
  echo -e "\n${COLOR}_____ Setting up Homebrew _____${NO_COLOR}\n"

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function config_zsh() {
  echo -e "\n${COLOR}_____ Setting up ZSH _____${NO_COLOR}\n"

  ZSH_DIR="~/.oh-my-zsh"

  brew install zsh
  chsh -s /usr/local/bin/zsh

  # set zsh theme
  cp ./zsh-themes/* "${ZSH_DIR}/custom/themes"
  sed -i '' -e 's/ZSH_THEME=.*/ZSH_THEME="nt9"/' ~/.zshrc
}

function config_git() {
  echo -e "\n${COLOR}_____ Setting up Git _____${NO_COLOR}\n"

  git config --global user.email ${GIT_EMAIL}
  git config --global user.name ${GIT_USERNAME}
  # git config --global credential.helper osxkeychain
  ssh-keygen -t rsa -b 4096 -C ${GIT_EMAIL}
  git config --global core.editor vim
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
}

function config_JS_env() {
  echo -e "\n${COLOR}_____ Setting up JavaScript environment _____${NO_COLOR}\n"

  brew install node
  declare -a global_packages=(
    @angular/cli 
    @vue/cli 
    eslint 
    typescript 
    create-react-app 
    webpack 
    yarn 
    firebase-tools
  )
  npm i -g ${global_packages[@]}
}

function config_py_env() {
  echo -e "\n${COLOR}_____ Setting up Python environment _____${NO_COLOR}\n"

  brew install python3
  sudo pip install virtualenv virtualenvwrapper
  echo -e "export WORKON_HOME=~/.virtualenvs" >> ~/.zshrc
  echo -e "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.zshrc
  source ~/.zshrc
}

source .env

xcode-select --install

config_brew

config zsh

config_git

config_JS_env

config_py_env
