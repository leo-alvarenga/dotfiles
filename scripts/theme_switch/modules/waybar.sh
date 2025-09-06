WAYBAR_CONFIG_DIR=~/.config/waybar

WB_LAYOUT=config.jsonc
WB_STYLE=style.css
WB_THEME=theme.css

FILES=($WB_LAYOUT $WB_STYLE $WB_THEME)
TARGET_THEME_DIR="$WAYBAR_CONFIG_DIR/themes/$1"

if [[ ! -d "$TARGET_THEME_DIR" ]]; then
    log "[FATAL] Missing '$1' theme directory"
    exit 1
fi

for file in "${FILES[@]}"; do
    filename="$TARGET_THEME_DIR/$file"

    if [[ ! -e "$filename" ]]; then
        log "[FATAL] Missing '$filename' file"
        exit 1
    fi   
done

cp $TARGET_THEME_DIR/* $WAYBAR_CONFIG_DIR

