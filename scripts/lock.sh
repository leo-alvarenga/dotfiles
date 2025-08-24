#!/usr/bin/env bash

##################### THEMES #########################

# Colors from Catpuccin Mocha

CAT_MOCHA_BASE=1e1e2e #1e1e2e
CAT_MOCHA_BASE_50=1e1e2eaa #1e1e2eaa
CAT_MOCHA_BLUE=89b4fa #89b4fa
CAT_MOCHA_RED=f38ba8 #f38ba8
CAT_MOCHA_CRUST=11111b #11111b
CAT_MOCHA_CRUST_50=11111baa #11111baa
CAT_MOCHA_GREEN=a6e3a1 #a6e3a1
CAT_MOCHA_MAUVE=cba6f7 #cba6f7
CAT_MOCHA_SUBTEXT_1=bac2de #bac2de
CAT_MOCHA_TEXT=cdd6f4 #cdd6f4

# Colors from Rose Pine

ROSE_PINE_BASE=191724 #191724
ROSE_PINE_BASE_50=191724aa #191724aa
ROSE_PINE_PINE=31748f #31748f
ROSE_PINE_LOVE=eb6f92 #eb6f92
ROSE_PINE_OVERLAY=26233a #26233a
ROSE_PINE_OVERLAY_50=26233aaa #26233aaa
ROSE_PINE_FOAM=9ccfd8 #9ccfd8
ROSE_PINE_ROSE=ebbcba #ebbcba
ROSE_PINE_SUBTLE=908caa #908caa
ROSE_PINE_TEXT=e0def4 #e0def4

######################################################

BLUR="7x5"
VIGNETTE="0.5:0.5"
FONT_SIZE=32
GRACE=1
INDICATOR_RADIUS=150
INDICATOR_THICKNESS=8
SCALING="fill"

# Schema:
# *_CAPS_COLOR -> when capslock is on
# *_CLEAR_COLOR -> when cleared (backspace or del)
# *_COLOR -> default color
# *_VER_COLOR -> when verified and authorized
# *_WRONG_COLOR -> when the password entered is wrong

# Ring:
RING_CAPS_COLOR=""
RING_CLEAR_COLOR=""
RING_COLOR=""
RING_VER_COLOR=""
RING_WRONG_COLOR=""

# Key highlights:
KEY_HL_COLOR=""
CLEAR_HL_COLOR=""
CAPS_CLEAR_HL_COLOR=""
CAPS_KEY_HL_COLOR=""

# Text:
CAPS_TEXT=""
TEXT=""

# Others:
BASE_50=""
TRANSPARENT=00000000 #00000000

function load_theme() {
    case $1 in
        rose_pine)
            # Ring:
            RING_CAPS_COLOR=$ROSE_PINE_PINE
            RING_CLEAR_COLOR=$ROSE_PINE_PINE
            RING_COLOR=$ROSE_PINE_ROSE
            RING_VER_COLOR=$ROSE_PINE_FOAM
            RING_WRONG_COLOR=$ROSE_PINE_LOVE

            # Key highlights:
            KEY_HL_COLOR=$ROSE_PINE_OVERLAY_50
            CLEAR_HL_COLOR=$ROSE_PINE_OVERLAY_50
            CAPS_CLEAR_HL_COLOR=$ROSE_PINE_OVERLAY_50
            CAPS_KEY_HL_COLOR=$ROSE_PINE_OVERLAY_50

            # Text:
            CAPS_TEXT=$ROSE_PINE_SUBTLE
            TEXT=$ROSE_PINE_TEXT

            # Others:
            BASE_50=$ROSE_PINE_BASE_50
            TRANSPARENT=00000000 #00000000
        ;;

        *)
            # Ring:
            RING_CAPS_COLOR=$CAT_MOCHA_BLUE
            RING_CLEAR_COLOR=$CAT_MOCHA_BLUE
            RING_COLOR=$CAT_MOCHA_MAUVE
            RING_VER_COLOR=$CAT_MOCHA_GREEN
            RING_WRONG_COLOR=$CAT_MOCHA_RED

            # Key highlights:
            KEY_HL_COLOR=$CAT_MOCHA_CRUST_50
            CLEAR_HL_COLOR=$CAT_MOCHA_CRUST_50
            CAPS_CLEAR_HL_COLOR=$CAT_MOCHA_CRUST_50
            CAPS_KEY_HL_COLOR=$CAT_MOCHA_CRUST_50

            # Text:
            CAPS_TEXT=$CAT_MOCHA_SUBTEXT_1
            TEXT=$CAT_MOCHA_TEXT

            # Others:
            BASE_50=$CAT_MOCHA_BASE_50
            TRANSPARENT=00000000 #00000000
        ;;
    esac
}

function lock() {
    load_theme $1

    swaylock  \
        --clock \
        --daemonize  \
        --ignore-empty-password  \
        --indicator \
        --indicator-caps-lock  \
        --indicator-idle-visible  \
        --scaling $SCALING\
        --screenshots \
        --show-failed-attempts  \
        --show-keyboard-layout \
        --timestr "%Hh %Mm %Ss" \
        --effect-blur $BLUR \
        --effect-vignette $VIGNETTE \
        --font-size $FONT_SIZE \
        --grace $GRACE \
        --indicator-radius $INDICATOR_RADIUS \
        --indicator-thickness $INDICATOR_THICKNESS \
        --ring-caps-lock-color $RING_CAPS_COLOR \
        --ring-clear-color $RING_CLEAR_COLOR \
        --ring-color $RING_COLOR \
        --ring-ver-color $RING_VER_COLOR \
        --ring-wrong-color $RING_WRONG_COLOR \
        --bs-hl-color $CLEAR_HL_COLOR \
        --key-hl-color $KEY_HL_COLOR \
        --caps-lock-bs-hl-color $CAPS_CLEAR_HL_COLOR \
        --caps-lock-key-hl-color $CAPS_KEY_HL_COLOR \
        --line-color $TRANSPARENT \
        --line-clear-color $TRANSPARENT \
        --line-caps-lock-color $TRANSPARENT \
        --inside-clear-color $BASE_50 \
        --inside-caps-lock-color $BASE_50 \
        --inside-color $BASE_50 \
        --inside-ver-color $BASE_50 \
        --inside-wrong-color $BASE_50 \
        --separator-color $TRANSPARENT \
        --text-caps-lock-color $CAPS_TEXT \
        --text-color $TEXT \
        --text-clear-color $TEXT \
        --text-ver-color $TEXT \
        --text-wrong-color $TEXT
}

lock $1
