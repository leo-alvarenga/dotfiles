#!/bin/bash

LOCK_IMAGE_PATH="$HOME/Pictures/wallpapers/win10_funny.png"
RESIZED_IMAGE_PATH="$HOME/Pictures/wallpapers/lock_resize_auto.png"

# greps screen info, filter to get dimension and cut off everything but the actual value
RES="$(xdpyinfo | grep dimensions | cut -d' ' -f7)"


convert -scale "$RES" "$LOCK_IMAGE_PATH" "$RESIZED_IMAGE_PATH"

# locks screen, enables pointer, failed attempts count and sets wallpaper
i3lock --pointer default --image "$RESIZED_IMAGE_PATH" --show-failed-attempts

# actually suspends the machine
systemctl suspend
