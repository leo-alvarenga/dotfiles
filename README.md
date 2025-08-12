# Dotfiles (WIP)

## Current setup

- Distro: CachyOS
- DM: SDDM
- DE (Wayland protocol only):
  1. Sway (and its stack) + Waybar
  2. Plasma

## Dependencies (so far)

- `ttf-nerd-fonts-symbols` (Nerd Fonts icons)
- `lua`
- `swayfx`
- `swaybg`
- `swaylock-effects`
- `swayidle`
- `waybar`

## Dotfile helper

In this repository, I've included my own personal Dotfile helper script, written in Lua.
Run `lua dotfile_helper.lua --help` to learn how to use it.

## Roadmap

- [x] Bare-bones Sway config
- [x] Bare-bones Waybar config
- [x] Dotfile helper
- [x] Add Swaylock config
- [x] Add Swayidle config
- [ ] Bugfix issue with volume control keys
- [ ] Solve "sticky" drag with mouse
- [ ] Improve Waybar config
