#!/usr/bin/env bash

function get_count() {
    echo $(swaync-client -c)
}

function main() {
    case $1 in
        count)
            get_count
        ;;
        *)
            exit 0
        ;;
    esac
}

main $1