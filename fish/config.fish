if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g PATH "$PATH:/usr/local/bin"

alias theme_switch="$HOME/.config/scripts/theme_switch/theme_switch.sh"

starship init fish | source

