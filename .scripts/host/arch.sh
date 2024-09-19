#!/usr/bin/env sh

source ./.scripts/lib/preinstall.sh
source ./.scripts/lib/terminal/tui.sh
source ./.scripts/lib/common.sh
source ./.scripts/lib/cleanup.sh

function pkg() {
  if command -v paru &> /dev/null
  then
    paru $@
  else
    sudo pacman $@
  fi
}

function check_and_install() {
  if ! command -v $1 &> /dev/null
  then
    pkg -S $1
  fi
}

function system_update() {
  log ">>> Update system"

  pkg -Syu --noconfirm

  log "<<< Update system"
}

function install_git() {
  log ">>> Git"

  pkg -S git

  log "<<< Git"
}

function aur_helper() {
  log ">>> Paru"

  pkg -S --needed base-devel
  git clone https://aur.archlinux.org/paru-git.git ./tmp/paru
  (cd ./tmp/paru && yes y | makepkg -si)
  rm -rf ./tmp/paru

  log "<<< Paru"
} 

function install_zsh() {
  log ">>> ZSH"
  
  pkg -S zsh

  gum confirm "Do you want to make zsh the default shell?" && (chsh -s $(which zsh) && zsh)

  log "<<< ZSH"
}

function packages() {
  log ">>> Packages"

  PACKAGES=$(cat ./.scripts/packages.txt | gum choose --no-limit --header "Which packages would you like to install?")
  pkg -S $PACKAGES

  log "<<< Packages"
}

function languages_dependencies() {
  log ">>> Languages dependencies"

  pkg -S jdk-openjdk unixodbc ncurses libssh wxwidgets-gtk3 wxwidgets-common unzip

  log "<<< Languages dependencies"
}

echo ">>> Archlinux setup"
preinstall sudo pacman -S
system_update
intall_git
aur_helper
intall_zsh
packages
languages_dependencies
languages
shell_setup
fonts ~/.fonts/
symlink
cleanup sudo pacman -Rsn
echo "<<< Archlinux setup"