#!/usr/bin/env bash

MENU=fuzzel
MENU_PID=$(pidof $MENU)

if [[ -z $MENU_PID ]]; then
    exec $MENU
    exit 0
fi

kill $MENU_PID
