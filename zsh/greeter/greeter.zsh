#!/usr/bin/env zsh

# Kanagawa Greeter

# Kanagawa color palette (from starship.toml)
KANAGAWA_BLUE="\033[38;2;126;156;216m"      # #7E9CD8
KANAGAWA_GREEN="\033[38;2;118;148;106m"     # #76946A
KANAGAWA_YELLOW="\033[38;2;192;163;110m"    # #C0A36E
KANAGAWA_ORANGE="\033[38;2;255;160;102m"    # #FFA066
KANAGAWA_RED="\033[38;2;195;64;67m"         # #C34043
KANAGAWA_MAGENTA="\033[38;2;149;127;184m"   # #957FB8
KANAGAWA_CYAN="\033[38;2;122;168;159m"      # #7AA89F
KANAGAWA_FG="\033[38;2;220;215;186m"        # #DCD7BA
KANAGAWA_FG_DIM="\033[38;2;114;113;105m"    # #727169
RESET="\033[0m"

# Configuration
QUOTES_FILE="${HOME}/.config/zsh/greeter/quotes.txt"

# Function to print a random quote
print_quote() {
    if [[ -f "$QUOTES_FILE" ]]; then
        local quote=$(shuf -n 1 "$QUOTES_FILE" 2>/dev/null || sort -R "$QUOTES_FILE" | head -n 1)
        if [[ -n "$quote" ]]; then
            echo ""
            echo -e "${KANAGAWA_FG_DIM}\"${quote}\"${RESET}"
        fi
    fi
}

# Main greeter function
show_greeter() {
    # Print random zen quote
    print_quote
}

# Run the greeter
show_greeter
