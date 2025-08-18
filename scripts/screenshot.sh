#!/bin/bash

function get_filename() {
    echo $(xdg-user-dir PICTURES)/$(date +'%s_grim.png')
}

function all_outputs() {
    echo grim $1
}

function main() {
    FILENAME=get_filename
    OUTPUT=""
    
    case $1 in
        *)
            OUTPUT="$(all_outputs $FILENAME)"
        ;;
    esac

    case $2 in
        copy)
            echo $OUTPUT | wl-copy
        ;;
        show)
            ghostty -e "chafa -f kitty $FILENAME"
        ;;
        *)
            exit 0
        ;;
    esac
}

main $1
