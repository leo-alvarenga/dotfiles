FUZZEL_CONFIG_DIR=~/.config/fuzzel

set -e
set -o pipefail

if [[ ! -e "$FUZZEL_CONFIG_DIR/themes/$1.ini" ]]; then
    log "[FATAL] Missing '$1.ini' file"
    exit 1
fi

cp "$FUZZEL_CONFIG_DIR/themes/$1.ini" "$FUZZEL_CONFIG_DIR/fuzzel.ini"

