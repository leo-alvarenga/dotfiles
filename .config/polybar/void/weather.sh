#!/bin/bash

service="wttr.in"
format="?format=3"

url="$service/$format"

# checks if the weather service, shoutout to @chubin, is online
if [[ $(ping -q -c 2 $service) > /dev/null ]]; then
	# if so, retrieves the current env temperature
	curl -s $url | cut -d ':' -f2 | cut -d ' ' -f5
else
	# if not, shows this
	echo "Unknown"
fi
