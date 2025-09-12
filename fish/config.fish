if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g PATH "$PATH:/usr/local/bin"

starship init fish | source

