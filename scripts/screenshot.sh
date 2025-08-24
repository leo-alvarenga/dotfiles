#!/usr/bin/env bash

function get_filename() {
    echo $(xdg-user-dir PICTURES)/$(date +'screenshot_%s_grim.png')
}

function selection() {
    grim -g "$(slurp)" $1
}

function all_outputs() {
    grim $1
}

function main() {
    FILENAME=$(get_filename)
    
    case $1 in
        all)
            all_outputs $FILENAME
        ;;
        select)
            selection $FILENAME
        ;;
        *)
            echo "Missing args"
            exit 1
        ;;
    esac

    case $2 in
        copy)
            cat $FILENAME | wl-copy
        ;;
        copy_path)
            echo $FILENAME | wl-copy
        ;;
        show)
            ghostty -e "chafa -f kitty $FILENAME"
        ;;
        *)
            exit 0
        ;;
    esac
}

main $1 $2
