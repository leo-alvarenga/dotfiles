#!/usr/bin/env bash

# Create separate funtions for each "module"
#   Ideally, these would have separate files for each
#   SHould it be a script or a binary?

set -eo pipefail # Do not pipe when an error has occurred

log() {
    echo -e $1
}

export -f log

print_progress() {
    local job_count=$(( ${#MODULES[@]} + 2))
    log "\t\tProgress: $COUNTER/$job_count\n"


    COUNTER=$((COUNTER+1))
    return
}

is_theme_available() {
    for option in "${AVAILABLE_THEMES[@]}"; do
        if [[ $option == $1 ]]; then
            return 0
        fi
    done

    return 1
}

display_available() {
    log "\tAvailable options:"

    for option in "${AVAILABLE_THEMES[@]}"; do
        log "\t\t- $option"
    done
}

are_all_handlers_available() {
    if [[ ! -d $MODULE_HANDLERS_DIR ]]; then
        log "[FATAL] The directory intented to contain all module handlers is empty or does not exist"
        log "\tExpected directory: '$MODULE_HANDLERS_DIR'"
        exit 1
    fi

    for module in "${MODULES[@]}"; do
        if [[ ! -e "$MODULE_HANDLERS_DIR/$module.sh" ]]; then
            log "[FATAL] Missing module handler file" 
            log "\tExpected file: '$MODULE_HANDLERS_DIR/$module.sh'"
            exit 1
        fi
    done
}

verify() {
    if [[ -z $TARGET_THEME ]]; then
        log "[FATAL] Missing target theme"
        display_available
        
        exit 1
    fi

    if ! is_theme_available "$TARGET_THEME"; then
        log "[FATAL] '$TARGET_THEME' is not a valid theme"
        display_available
        
        exit 1
    fi

    if [[ ! -z $CURRENT_THEME ]]; then
        ICUR_THEME=$CURRENT_THEME
    fi

    are_all_handlers_available
}

setup() {
    log "Initial setup..."
    print_progress
    return
}

switch_() {
    local FILE="$MODULE_HANDLERS_DIR/$1.sh"
    bash -c "$FILE \"$2\" \"$3\""
}

switch_theme() {
    for module in "${MODULES[@]}"; do
        log "Switching '$module' theme..."
        print_progress

        switch_ $module $TARGET_THEME $WALLPAPER_MODE
    done
}

post_switch() {
    log "Executing post switch adjustments..."
    print_progress

    bash -c $SCRIPT_DIR/triggers/post_switch.sh
}

main() {
    clear
    log "Theme Switcher\n"

    verify
    setup
    switch_theme 
    post_switch
}

export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COUNTER=1
MODULES=(fuzzel ghostty nvim sway wallpaper waybar wlogout)
AVAILABLE_THEMES=(gruvbox_dark catppuccin_mocha rose_pine)
ICUR_THEME="$AVAILABLE_THEMES[0]"
TARGET_THEME=$1
WALLPAPER_MODE=$2
MODULE_HANDLERS_DIR=$SCRIPT_DIR/modules

main $0

