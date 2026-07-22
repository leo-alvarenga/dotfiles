if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
    export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH
fi
