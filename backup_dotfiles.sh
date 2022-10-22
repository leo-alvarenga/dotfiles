#!/bin/bash

cp ~/.config/backup_dotfiles.sh ~/Code/dotfiles
cp -r ~/.config/awesome ~/Code/dotfiles/.config
cp -r ~/.config/picom ~/Code/dotfiles/.config
cp -r ~/.config/alacritty ~/Code/dotfiles/.config

cp -r ~/.config/bspwm ~/Code/dotfiles/.config
cp -r ~/.config/sxhkd ~/Code/dotfiles/.config
cp -r ~/.config/polybar ~/Code/dotfiles/.config

cp ~/.zshrc ~/Code/dotfiles/.config/

cp -r /home/caesar/Pictures/wallpapers ~/Code/dotfiles/assets
