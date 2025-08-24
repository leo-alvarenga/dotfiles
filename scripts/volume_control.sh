#!/usr/bin/env bash

INPUT_VOLUME=$(pamixer --get-volume)
OUTPUT_VOLUME=$(pamixer --get-volume)

function increase_output() {
    if [[ $OUTPUT_VOLUME == '100' ]]; then
        exit 0
    fi

    pactl set-sink-volume @DEFAULT_SINK@ +5%
}

function decrease_output() {
    if [[ $OUTPUT_VOLUME == '0' ]]; then
        exit 0
    fi

    pactl set-sink-volume @DEFAULT_SINK@ -5%
}

function toggle_mute_output() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

function increase_input() {
    pactl set-source-volume @DEFAULT_SOURCE@ +5%
}

function decrease_input() {
    pactl set-source-volume @DEFAULT_SOURCE@ -5%
}

function toggle_mute_input() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
}

function handle_input() {
    case $1 in
        down)
            decrease_input
        ;;
        up)
            increase_input
        ;;
        mute)
            toggle_mute_input
        ;;
        *)
            exit 0
        ;;
    esac
}

function handle_output() {    
    case $1 in
        down)
            decrease_output
        ;;
        up)
            increase_output
        ;;
        mute)
            toggle_mute_output
        ;;
        *)
            exit 0
        ;;
    esac
}

function main() {
    if [[ -z "$2" ]]; then
        handle_output $1
    fi
    
    case $1 in
        input)
            handle_input $2
        ;;
        *)
            handle_output $2
        ;;
    esac
}

main $1 $2
