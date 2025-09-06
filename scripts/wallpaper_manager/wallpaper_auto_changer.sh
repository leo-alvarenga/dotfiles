#!/usr/bin/env bash

# Check if directory argument is given
DIR="$1"
PREFFIX="$2"
TIMEOUT=$3

# Check if directory exists
if [ ! -d "$DIR" ]; then
  echo "Error: '$DIR' is not a directory."
  exit 1
fi

if [ -z "$PREFFIX" ]; then
  echo -e "Error: Missing preffix at \$2."
  exit 1
fi

if [ -z $TIMEOUT ]; then
    TIMEOUT=10
fi

# Loop through matching files
for file in "$DIR"/$PREFFIX*; do
  # Handle case when no files match
  [ -e "$file" ] || { echo "No files starting with '$PREFFIX' found in $DIR"; exit 0; }
  echo "Setting '$(basename "$file")' as wallpaper..."
  swww img $file

  sleep $TIMEOUT
done

