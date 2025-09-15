if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g NPM_LOCAL_PATH "$HOME/.local/share/npm"
set -g PATH "$NPM_LOCAL_PATH/bin:$PATH:/usr/local/bin:$HOME/.local/bin"

starship init fish | source

