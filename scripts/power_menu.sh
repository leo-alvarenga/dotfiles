#!/usr/bin/env bash

PREVIOUS_PID=$(pidof wlogout)

if [[ ! -z $PREVIOUS_PID ]]; then
    kill $PREVIOUS_PID
    exit 0
fi

wlogout

