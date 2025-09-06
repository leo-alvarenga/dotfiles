SWAY_CONFIG_DIR=~/.config/sway
SWAY_CONFIG_FILE=$SWAY_CONFIG_DIR/config
SWAY_THEMES_DIR=$SWAY_CONFIG_DIR/themes

TARGET_THEME="$SWAY_THEMES_DIR/$1"

FILES=($SWAY_CONFIG_FILE $TARGET_THEME)
DIRS=($SWAY_CONFIG_DIR $SWAY_THEMES_DIR)

for dir in "${DIRS[@]}"; do
    if [[ ! -d "$dir" ]]; then
        log "[FATAL] Missing '$dir' directory"

        exit 1  
    fi
done

for file in "${FILES[@]}"; do
    if [[ ! -e "$file" ]]; then
        log "[FATAL] Missing '$file' file"

        exit 1  
    fi
done

sed -i '\|sway/themes/|c\'"include $TARGET_THEME" $SWAY_CONFIG_FILE

