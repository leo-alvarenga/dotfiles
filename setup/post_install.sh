#!/usr/bin/env bash

set -eo pipefail

source "$(dirname ${BASH_SOURCE[0]})/utils.sh"

declare -A LABELS=()

SEPARATOR=' '
DEFAULT_FMT="bold blue"
DOTFILES_REPO="https://github.com/leo-alvarenga/dotfiles"

## Early exit

if [[ $(whoami) == 'root' ]]; then
  echo "This script NOT should be ran as root"

  exit 1
fi

update_repos() {
  sudo pacman -Syy --needed --noconfirm > /dev/null 2>&1
}

install_deps() {
  sudo pacman -S --needed --noconfirm $@ > /dev/null 2>&1
}

install_rust() {
  if ! cargo --version &> /dev/null; then
    str_fmt "\n\n\nInstalling Rustc and Cargo..." "$DEFAULT_FMT"
    sleep 1
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
}

install_nvm() {
  if ! nvm --version &> /dev/null; then
    str_fmt "\n\n\nInstalling Nodejs via NVM..." "$DEFAULT_FMT"
    sleep 1
    curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  fi

  local zprofile="$HOME/.zprofile"
  local zshrc="$HOME/.zshrc"

  if [[ -f "$zprofile" ]]; then
    source "$HOME/.zprofile"
  fi

  if [[ -f "$zshrc" ]]; then
    source "$HOME/.zshrc"
  fi

  if nvm --version &> /dev/null; then
    str_fmt "\n\nInstalling and setting up Node.js LTS..." "$DEFAULT_FMT"
    sleep 1
    nvm install --lts
    nvm use --lts
  fi
}

install_lang_servers() {
  str_fmt "\n\n\nInstalling language servers and formatters dependant on Node.js ..." "$DEFAULT_FMT"
  
  if ! npm --version &> /dev/null; then
    log_fatal "Could not install! Missing npm!"
    exit 1
  fi

  local server_and_formatters=(@astrojs/language-server typescript-language-server vscode-langservers-extracted bash-language-servers yaml-language-server prettier)
  
  npm i -g ${server_and_formatters[@]} > /dev/null 2>&1
}

install_dependencies() {
  log_step() {
    str_fmt "Installing ${LABELS[$1]}" "$DEFAULT_FMT"
  }

  # Lower level deps
  local BASIC_DEPS=(curl wget git zsh man xdg-user-dirs which)
  local SHELL_UTILS=(bat less tree btop)

  LABELS[BASIC_DEPS]="basic dependencies"
  LABELS[SHELL_UTILS]="shell utilities"

  log_step "BASIC_DEPS"
  install_deps "${BASIC_DEPS[@]}"

  xdg-user-dirs-update

  log_step "SHELL_UTILS"
  install_deps "${SHELL_UTILS[@]}"

  str_fmt "Setting up zsh as default shell..." "$DEFAULT_FMT"
  sudo chsh -s /usr/bin/zsh

  ############################################################################

  # Services
  local SERVICES=(bluez iwd pulseaudio power-profiles-daemon)

  LABELS[SERVICES]="services"

  log_step "SERVICES"
  install_deps "${SERVICES[@]}"

  ############################################################################

  # Graphical env deps
  local GRAPHICAL_ENV=(ly hyprland swww dunst hyprlock hypridle waybar wl-clipboard chafa grim flameshot nwg-bar fuzzel ghostty)
  local FONTS=(ttf-dejavu otf-font-awesome)

  LABELS[GRAPHICAL_ENV]="graphical environment deps"
  LABELS[FONTS]="fonts"

  log_step "GRAPHICAL_ENV"
  install_deps "${GRAPHICAL_ENV[@]}"

  log_step "FONTS"
  install_deps "${FONTS[@]}"
  
  str_fmt "Enabling Ly as the greeter..." "bold blue"
  sudo systemctl disable getty@tty2.service
  sudo systemctl enable ly

  ############################################################################

  # Deps for my dev env
  local COMPILERS_AND_INTERPRETERS=(lua gcc make cmake go)
  local CODE_EDITOR_DEPS=(fzf zoxide)
  local CODE_EDITORS=(vim helix)

  LABELS[COMPILERS_AND_INTERPRETERS]="compilers and interpreters"
  LABELS[CODE_EDITOR_DEPS]="code editor dependencies"
  LABELS[CODE_EDITOR]="code editors"
  
  log_step "COMPILERS_AND_INTERPRETERS"
  install_deps "${COMPILERS_AND_INTERPRETERS[@]}"

  log_step "CODE_EDITOR_DEPS"
  install_deps "${CODE_EDITOR_DEPS[@]}"

  log_step "CODE_EDITORS"
  install_deps "${CODE_EDITORS[@]}"

  install_rust
  install_nvm
  install_lang_servers
  
  ############################################################################
  
  # QoL and config util
  local QOL=(brightnessctl pamixer pavucontrol)

  LABELS[QOL]="quality of life and configuration managers..."

  install_deps "${QOL[@]}"
}

setup_doas() {
  log_step "\n\nSetting up doas..."
  sleep 1

  
  install_deps doas

  log_step "Creating doas.conf"
  echo "permit persist setenv {PATH=/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin} :wheel" | sudo tee /etc/doas.conf > /dev/null
  sleep 0.2

  # Ensuring root owns the file and nobody else can edit it
  log_step "Changing doas.conf permissions"
  sudo chown -c root:root /etc/doas.conf
  sudo chmod -c 0400 /etc/doas.conf
}

setup_dotfile() {
  log_step "\n\nSetting up .config files..."
  sleep 1

  if [[ -d "$HOME/.config" ]]; then
    rm -rf "$HOME/.config"
  fi
  
  cd $HOME
  git clone "$DOTFILES_REPO" "$HOME/.config" > /dev/null

  ln -s "$HOME/.config/.zshrc" "$HOME/.zshrc"
  ln -s "$HOME/.config/.zshenv" "$HOME/.zshenv"
  ln -s "$HOME/.config/.profile" "$HOME/.profile"
  ln -s "$HOME/.config/.zprofile" "$HOME/.zprofile"
  ln -s "$HOME/.config/.p10k.zsh" "$HOME/.p10k.zsh"
}

post_setup() {
  reset

  log_step "All good! Ready to roll!\n\n"
}


install_dependencies
setup_doas
setup_dotfile

