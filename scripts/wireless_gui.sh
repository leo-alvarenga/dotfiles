#!/usr/bin/env bash
_PID=$(pidof iwmenu)

if [[ -z $_PID ]]; then
    iwmenu -l fuzzel -i xdg
    exit 0
fi

kill $_PID
