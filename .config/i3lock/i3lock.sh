#!/bin/bash

LOCK_IMAGE_PATH="$HOME/Pictures/wallpapers/i3lock_current_screen.png"
RESIZED_IMAGE_PATH="$HOME/Pictures/wallpapers/i3lock_current_screen_blurred.png"

# greps screen info, filter to get dimension and cut off everything but the actual value
RES="$(xdpyinfo | grep dimensions | cut -d' ' -f7)"

# blur strength
# use less than 20 tho, any values greater than that tends
# to cause the blur algorithm to take more than .3s to execute
BLUR="0x5"

if [[ $(cat "$LOCK_IMAGE_PATH") > /dev/null  ]]; then
	rm "$LOCK_IMAGE_PATH"
fi

scrot --file "$LOCK_IMAGE_PATH"
convert -scale "$RES" "$LOCK_IMAGE_PATH" "$RESIZED_IMAGE_PATH"
convert -blur "$BLUR" "$RESIZED_IMAGE_PATH" "$RESIZED_IMAGE_PATH"

# locks screen, enables mouse pointer, enables failed attempts count and sets wallpaper
i3lock --pointer default --image "$RESIZED_IMAGE_PATH" --show-failed-attempts

# actually suspends the machine
systemctl suspend
