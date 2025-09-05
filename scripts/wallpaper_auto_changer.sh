#!/usr/bin/env bash

# Check if directory argument is given
DIR="$1"

# Check if directory exists
if [ ! -d "$DIR" ]; then
  echo "Error: '$DIR' is not a directory."
  exit 1
fi

# Loop through matching files
for file in "$DIR"/gruvbox*; do
  # Handle case when no files match
  [ -e "$file" ] || { echo "No files starting with 'gruvbox' found in $DIR"; exit 0; }
  echo "$(basename "$file")"
done

