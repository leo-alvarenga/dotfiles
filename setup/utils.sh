#!/usr/bin/env bash

# Declare associative map (styles + colors)
declare -A FORMAT_MAP
FORMAT_MAP[reset]=0
FORMAT_MAP[bold]=1
FORMAT_MAP[dim]=2
FORMAT_MAP[italic]=3
FORMAT_MAP[underline]=4
FORMAT_MAP[blink]=5
FORMAT_MAP[reverse]=7
FORMAT_MAP[hidden]=8
FORMAT_MAP[strikethrough]=9

# Foreground colors
FORMAT_MAP[black]=30
FORMAT_MAP[red]=31
FORMAT_MAP[green]=32
FORMAT_MAP[yellow]=33
FORMAT_MAP[blue]=34
FORMAT_MAP[magenta]=35
FORMAT_MAP[cyan]=36
FORMAT_MAP[white]=37

# Bright foreground colors
FORMAT_MAP[bright_black]=90
FORMAT_MAP[bright_red]=91
FORMAT_MAP[bright_green]=92
FORMAT_MAP[bright_yellow]=93
FORMAT_MAP[bright_blue]=94
FORMAT_MAP[bright_magenta]=95
FORMAT_MAP[bright_cyan]=96
FORMAT_MAP[bright_white]=97

# Background colors
FORMAT_MAP[bg_black]=40
FORMAT_MAP[bg_red]=41
FORMAT_MAP[bg_green]=42
FORMAT_MAP[bg_yellow]=43
FORMAT_MAP[bg_blue]=44
FORMAT_MAP[bg_magenta]=45
FORMAT_MAP[bg_cyan]=46
FORMAT_MAP[bg_white]=47

FORMAT_MAP[bg_bright_black]=100
FORMAT_MAP[bg_bright_red]=101
FORMAT_MAP[bg_bright_green]=102
FORMAT_MAP[bg_bright_yellow]=103
FORMAT_MAP[bg_bright_blue]=104
FORMAT_MAP[bg_bright_magenta]=105
FORMAT_MAP[bg_bright_cyan]=106
FORMAT_MAP[bg_bright_white]=107


# Function: str_fmt "<styles...>" "<text>"
get_ansi_fmt() {
    local styles="$1"
    shift
    local text="$*"

    local codes=()
    for style in $styles; do
        if [[ -n "${FORMAT_MAP[$style]}" ]]; then
            codes+=("${FORMAT_MAP[$style]}")
        fi
    done

    # Join codes with ;
    local code_str
    code_str=$(IFS=";"; echo "${codes[*]}")

    # Wrap text with escape codes
    echo -e "\033[${code_str}m${text}\033[${FORMAT_MAP[reset]}m"
}

str_join() {
  local IFS="$1"
  shift
  echo "$*"
}

# Wrapper to log something to stdout
str_log() {
  echo -e "$1"
}

str_fmt() {
    if [[ ! -z "$2" ]]; then
        str_log "$1"
        return
    fi
    
   str_log "$(get_ansi_fmt "$2" "$1")" 
}

str_log_fatal() {
  local prefix=$(get_ansi_fmt "bold red" "[FATAL]")
  local msg=$(get_ansi_fmt "italic red" "$1")
    
  str_log "$prefix $msg"
  exit 1
}

str_log_warn() {
  local prefix=$(get_ansi_fmt "bold yellow" "[WARNING]")
  local msg=$(get_ansi_fmt "italic yellow" "$1")
    
  str_log "$prefix $msg"
}

