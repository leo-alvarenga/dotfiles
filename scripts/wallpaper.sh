#!/usr/bin/env bash

BG_PATH=$1

if [[ -z $BG_PATH ]]; then
    echo "Missing wallpaper file"
    exit 1
fi

swww query
if [ $? -ne 0 ] ; then
[ -e $XDG_RUNTIME_DIR/swww.socket ] && rm  $XDG_RUNTIME_DIR/swww.socket
    swww-daemon --format xrgb &
fi

sww img $BG_PATH
