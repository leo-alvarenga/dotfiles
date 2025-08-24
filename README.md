# Dotfiles (WIP)

## Current setup ([Preview](#preview))
- Distro: Arch Linux
- DM: Ly (TUI)
- WM (Compositor): Sway (and its stack) + Waybar

## Dependencies (so far)

### Compilers and Interpreters
- `lua`
- `go`
- `rustc` - Via [`rustup`](https://www.rust-lang.org/learn/get-started)

### Core
- `pulseaudio`
- `nerd-fonts` - Whole group
- `swayfx` - Via AUR or manual build
- `swww`
- `swaync`
- `swaylock-effects` - Via AUR or manual build
- `swayidle`
- `waybar`
- `eww` - Manually built
- `ghostty`
- `fuzzel`

### Utilities
- `xdg-user-dirs`
- `brightnessctl`
- `pamixer`
- `pavucontrol`
- `power-profiles-daemon`
- `starship`
- `btop`
- `tree`
- `wl-clipboard`
- `fastfetch`
- `slurp`
- `grim`
- `chafa`

## Dotfile helper

In this repository, I've included my own personal Dotfile helper script, written in Lua.
Run `lua dotfile_helper.lua --help` to learn how to use it.

## Roadmap

- [x] Bare-bones Sway config
- [x] Bare-bones Waybar config
- [x] Dotfile helper
- [x] Add Swaylock config
- [x] Add Swayidle config
- [x] Improve Waybar config
- [x] Bugfix issue with volume control keys
- [x] Solve "sticky" drag with mouse
- [ ] Reorganize this repo
- [ ] Rethink how theme switching should work
- [ ] Add independent menus
    - [ ] Power menu
- [ ] Config `fastfetch`

## Preview
![Empty workspace](./docs/empty.png)
