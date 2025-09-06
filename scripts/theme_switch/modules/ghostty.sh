declare -A THEME_MAP

GHOSTTY_CONFIG_FILE=~/.config/ghostty/config

THEME_MAP[gruvbox_dark]="GruvboxDark"
THEME_MAP[rose_pine]="rose-pine"
THEME_MAP[catppuccin_mocha]="catppuccin-mocha"

TARGET_THEME="${THEME_MAP[gruvbox_dark]}"

if [[ ! -e "$GHOSTTY_CONFIG_FILE" ]]; then
    log "[FATAL] Missing config file ('$GHOSTTY_CONFIG_FILE')"
    exit 1
fi

# Replace target theme if it's valid
# Otherwise, fallback to default
if [[ ! -z "${THEME_MAP[$1]}" ]]; then
    TARGET_THEME="${THEME_MAP[$1]}"
fi

sed -i "s|^theme = .*|theme = $TARGET_THEME|" $GHOSTTY_CONFIG_FILE

