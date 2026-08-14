# Aliases and important vars
export VISUAL="$(which nvim)"
export EDITOR="$VISUAL"

if [[ -d "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi
