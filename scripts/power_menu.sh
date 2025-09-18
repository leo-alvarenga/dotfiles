#!/usr/bin/env bash

POWER_MENU=nwg-bar
PREVIOUS_PID=$(pidof $POWER_MENU)

if [[ ! -z $PREVIOUS_PID ]]; then
    kill $PREVIOUS_PID
    exit 0
fi

$POWER_MENU

