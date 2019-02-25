#! /bin/bash

COLOR="\033[1;32m"
NO_COLOR="\033[0m"

config_brew() {
  echo -e "\n${COLOR}_____ Setting up Homebrew _____${NO_COLOR}\n"

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

config_zsh() {
  echo -e "\n${COLOR}_____ Setting up ZSH _____${NO_COLOR}\n"

  local ZSH_DIR="~/.oh-my-zsh"

  brew install zsh
  chsh -s /usr/local/bin/zsh

  # set zsh theme
  cp ./zsh-themes/* "${ZSH_DIR}/custom/themes"
  sed -i '' -e 's/ZSH_THEME=.*/ZSH_THEME="nt9"/' ~/.zshrc
}

config_git() {
  echo -e "\n${COLOR}_____ Setting up Git _____${NO_COLOR}\n"

  git config --global user.email ${GIT_EMAIL}
  git config --global user.name ${GIT_USERNAME}
  git config --global core.editor vim
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto

  # setup github ssh
  ssh-keygen -t rsa -b 4096 -C ${GIT_EMAIL}
  eval "$(ssh-agent -s)"
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  local red='\033[0;31m'
  echo "\n${red}Public ssh key copied to clipboard; paste it where it's supposed to be on GitHub :-) ${NO_COLOR}\n"
}

config_JS_env() {
  echo -e "\n${COLOR}_____ Setting up JavaScript environment _____${NO_COLOR}\n"

  brew install node
  declare -a global_packages=(
    yarn
    @vue/cli
    gatsby-cli
    @nestjs/cli
    @angular/cli
    react-native
    create-react-app
    jest
    eslint
    nodemon
    webpack
    typescript
    firebase-tools
  )
  npm i -g ${global_packages[@]}
}

config_py_env() {
  echo -e "\n${COLOR}_____ Setting up Python environment _____${NO_COLOR}\n"

  brew install python3
  sudo pip install virtualenv virtualenvwrapper

  cat <<EOF >> ~/.zshrc
    export WORKON_HOME=~/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
EOF

  source ~/.zshrc
}

config_aws_cli() {
  echo -e "\n${COLOR}_____ Setting up AWS CLI _____${NO_COLOR}\n"

  brew install awscli
  aws configure

  # To do - set access key ID & secret access key
}

install_apps() {
  echo -e "\n${COLOR}_____ Installing apps _____${NO_COLOR}\n"

  declare -a apps=(
    vlc
    slack
    iterm2
    spotify
    tunnelbear
    google-chrome
    visual-studio-code
  )
  brew cask install ${apps[@]}
}

source .env

xcode-select --install

config_brew

config_zsh

config_git

config_JS_env

config_py_env

install_apps

# To do - Logout & login again to finalize configs
