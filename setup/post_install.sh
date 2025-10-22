#!/usr/bin/env bash

set -eo pipefail

source "$(dirname ${BASH_SOURCE[0]})/utils.sh"

declare -A LABELS=()

SEPARATOR=' '
DEFAULT_FMT="blue"
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

uninstall_with_doas() {
  doas pacman -Rcns --noconfirm $@ > /dev/null 2>&1
}

log_step() {
  str_fmt "Installing ${LABELS[$1]}" "$DEFAULT_FMT"
}

install_rust() {
  if ! cargo --version &> /dev/null; then
    str_fmt "Installing Rustc and Cargo..." "$DEFAULT_FMT"
    sleep 1
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
}

install_nvm() {
  if ! nvm --version &> /dev/null; then
    str_fmt "Installing Nodejs via NVM..." "$DEFAULT_FMT"
    sleep 1
    curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash > /dev/null 2>&1
  fi

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  local zprofile="$HOME/.zprofile"
  local zshrc="$HOME/.zshrc"

  if [[ -f "$zprofile" ]]; then
    source "$HOME/.zprofile"
  fi

  if [[ -f "$zshrc" ]]; then
    source "$HOME/.zshrc"
  fi

  if nvm --version &> /dev/null; then
    str_fmt "Installing and setting up Node.js LTS..." "$DEFAULT_FMT"
    sleep 1
    nvm install --lts
    nvm use --lts
  fi
}

install_lang_servers() {
  str_fmt "Installing language servers and formatters dependant on Node.js ..." "$DEFAULT_FMT"
  
  if ! npm --version &> /dev/null; then
    log_fatal "Could not install! Missing npm!"
    exit 1
  fi

  local server_and_formatters=(@astrojs/language-server typescript-language-server vscode-langservers-extracted bash-language-server yaml-language-server prettier neovim)
  
  npm i -g ${server_and_formatters[@]} > /dev/null 2>&1
}

install_tmux() {
  install_deps tmux
}

setup_tmux() {
  if ! tmux -c exit &> /dev/null; then
    install_tmux
  fi

  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [[ -d "$tpm_dir" ]]; then
    rm -rf "$tpm_dir" > /dev/null 2>&1
  fi

  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
}

install_dependencies() {
  # Lower level deps
  local BASIC_DEPS=(curl wget git zsh man xdg-user-dirs which)
  local SHELL_UTILS=(bat less tree btop fd ripgrep)

  LABELS[BASIC_DEPS]="basic dependencies"
  LABELS[SHELL_UTILS]="shell utilities"

  log_step "BASIC_DEPS"
  install_deps "${BASIC_DEPS[@]}"

  xdg-user-dirs-update --force

  log_step "SHELL_UTILS"
  install_deps "${SHELL_UTILS[@]}"
  setup_tmux

  str_fmt "Setting up zsh as default shell..." "$DEFAULT_FMT"
  chsh -s $(chsh --list-shells | grep zsh | sed -n '1p')

  ############################################################################

  if [[ -z $WSL_MODE ]]; then
    # Services
    local SERVICES=(bluez iwd pulseaudio power-profiles-daemon)

    LABELS[SERVICES]="services"

    log_step "SERVICES"
    install_deps "${SERVICES[@]}"

    ############################################################################

    if [[ -z $MINIMAL_MODE ]]; then
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
    fi
  fi

  ############################################################################

  # Deps for my dev env
  local COMPILERS_AND_INTERPRETERS=(lua luarocks python gcc make cmake go)
  local CODE_EDITOR_DEPS=(fzf zoxide fd ripgrep unzip gzip)
  local CODE_EDITORS=(vim helix neovim)

  LABELS[COMPILERS_AND_INTERPRETERS]="compilers and interpreters"
  LABELS[CODE_EDITOR_DEPS]="code editor dependencies"
  LABELS[CODE_EDITORS]="code editors"
  
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
  str_fmt "Setting up doas..." "$DEFAULT_FMT"
  sleep 1

  install_deps doas

  str_fmt "Creating doas.conf" "$DEFAULT_FMT"
  echo "permit persist setenv {PATH=/usr/bin:/usr/sbin:/bin:/usr/local/bin:/usr/local/sbin} :wheel" | sudo tee /etc/doas.conf > /dev/null
  sleep 0.2

  # Ensuring root owns the file and nobody else can edit it
  str_fmt "Changing doas.conf permissions" "$DEFAULT_FMT"
  sudo chown -c root:root /etc/doas.conf
  sudo chmod -c 0400 /etc/doas.conf

  if [[ ! -z $REMOVE_SUDO && $REMOVE_SUDO == true ]]; then
    uninstall_with_doas sudo
  fi
}

setup_dotfiles() {
  str_fmt "Setting up .config files..." "$DEFAULT_FMT"
  sleep 1

  cd $HOME

  local files=(.zshenv .profile .zprofile .p10k.zsh .zshrc)

  for file in ${files[@]}; do
    ln -f "$HOME/.config/$file" "$HOME/$file" > /dev/null 2>&1
  done
}

post_setup() {
  str_fmt "All good! Ready to roll!\n\n" "$DEFAULT_FMT"
}

if [[ $1 == '-h' || $1 == '--help' ]]; then
  str_fmt "$(str_fmt "Post install setup script" "blue")\n\n" "bold"

  str_fmt "Help (-h or --help) is the only option available" "$DEFAULT_FMT"
  str_fmt "To modify the default behavior, use the following ENV vars instead:" "$DEFAULT_FMT"
  
  str_fmt "\n\n\t- WLS_MODE - When true, only basic and low level\n\t dependencies are installed; Dotfiles are still symlinked" "$DEFAULT_FMT"
  str_fmt "\n\t- MINIMAL_MODE - When true, all dependencies are\n\t installed except for those related to a graphical environmet setup;\n\t Dotfiles are still symlinked" "$DEFAULT_FMT"
  str_fmt "\n\t- SYNC_MODE - When true, no dependencies are installed,\n\t meaning the only change done is the symlinking of the dotfiles" "$DEFAULT_FMT"
  str_fmt "\n\t- USE_DOAS - When true, doas is installed and setup to\n\t be used; WILL BE OVERWRITTEN BY THE PREVIOUS VARIABLES" "$DEFAULT_FMT"
  str_fmt "\n\t- REMOVE_SUDO - When true and USE_DOAS is also true,\n\t uninstall sudo completly; WILL BE OVERWRITTEN BY THE PREVIOUS VARIABLES" "$DEFAULT_FMT"
 
  exit 0
fi

# This had to be added here; Script would break in WSL otherwise
if [[ -f "$HOME/.zshrc" ]]; then
  rm "$HOME/.zshrc"
fi

# When using this script with SYNC_MODE=true, only update ~/.config and other dotfiles
if [[ -z $SYNC_MODE || $SYNC_MODE != true ]]; then
  install_dependencies

  # Var is present and true
  if [[ ! -z $USE_DOAS && $USE_DOAS == true ]]; then
    setup_doas
  fi
fi

setup_dotfiles
post_setup
