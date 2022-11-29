#!/bin/bash

# xrandr --output HDMI2 --auto --same-as eDP1 --mode 1280x720
# xrandr --output eDP1 --mode 1280x720

arg=$1
if [[ -z $arg  ||  $arg == "reset" ]]; then
	xrandr --output eDP1 --rate 60 --mode 1366x768 --fb 1366x768
elif [[ $arg == "mirror-hdmi" ]]; then
	xrandr --output eDP1 --rate 60 --mode 1280x720 --fb 1920x1080 --panning 1920x1080* --output HDMI2 --mode 1920x1080 --same-as eDP1
fi

