#!/bin/bash

BLUR="7x5"
VIGNETTE="0.5:0.5"
FONT_SIZE=32
GRACE=1
INDICATOR_RADIUS=150
INDICATOR_THICKNESS=8
SCALING="fill"

# Colors from Catpuccin Mocha
# Schema:
# *_CAPS_COLOR -> when capslock is on
# *_CLEAR_COLOR -> when cleared (backspace or del)
# *_COLOR -> default color
# *_VER_COLOR -> when verified and authorized
# *_WRONG_COLOR -> when the password entered is wrong

BASE=1e1e2e #1e1e2e
BASE_50=1e1e2eaa #1e1e2eaa
BLUE=89b4fa #89b4fa
CRUST=11111b #11111b
CRUST_50=11111baa #11111baa
GREEN=a6e3a1 #a6e3a1
MAUVE=cba6f7 #cba6f7
SUBTEXT_1=bac2de #bac2de
TEXT=cdd6f4 #cdd6f4
TRANSPARENT=00000000 #00000000

# Ring:
RING_CAPS_COLOR=$BLUE
RING_CLEAR_COLOR=$BLUE
RING_COLOR=$MAUVE
RING_VER_COLOR=$GREEN
RING_WRONG_COLOR=$GREEN

# Key highlights
KEY_HL_COLOR=$CRUST_50
CLEAR_HL_COLOR=$CRUST_50
CAPS_CLEAR_HL_COLOR=$CRUST_50
CAPS_KEY_HL_COLOR=$CRUST_50

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
	--text-caps-lock-color $SUBTEXT_1 \
	--text-color $TEXT \
    --text-clear-color $TEXT \
	--text-ver-color $TEXT \
	--text-wrong-color $TEXT
