#!/usr/bin/env bash

set -e
set -o pipefail

log() {
    echo -e $1
}

display_usage() {
    log "\nUsage\n"
    log " -> <Command> [THEME] [MODE] [?INTERVAL|WALLPAPER]"

    log "MODES:"
    log "\t - static -> Defaults to either the WALLPAPER arg or a file named 'THEME_default.png'"
    log "\t - slide -> Every INTERVAL seconds, change to the next wallpaper available for the desired theme"
}

verify() {
    local ERROR_MSG=""

    if [[ ! -d $WALLPAPER_DIR ]]; then
        ERROR_MSG="Wallpaper dir '$WALLPAPER_DIR' does not exist"
    fi

    if [[ -z $THEME || -z $MODE ]]; then
        ERROR_MSG="Missing argument"
    fi

    if [[ ! -z "$ERROR_MSG" ]]; then
        log "[FATAL] $ERROR_MSG"

        display_usage $0
        exit 1
    fi
}

set_static() {
    local default_wallpaper="$WALLPAPER_DIR"/"$THEME"_default.png
    local wallpaper=$INTERVAL_OR_WALLPAPER

    if [[ -z $wallpaper ]]; then
        wallpaper=$default_wallpaper
    fi

    $SCRIPT_DIR/wallpaper.sh $wallpaper
}

main () {
    verify

    case $MODE in
        static)
            set_static
        ;;
        slide)
            $SCRIPT_DIR/wallpaper_auto_changer.sh $WALLPAPER_DIR $THEME $INTERVAL_OR_WALLPAPER
        ;;
        *)
            log ""
        ;;
    esac
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

THEME=$1
MODE=$2
INTERVAL_OR_WALLPAPER=$3

WALLPAPER_DIR=$HOME/.config/pictures/wallpapers

main $0

