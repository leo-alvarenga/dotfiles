# Dotfiles (WIP)

## Current setup ([Preview](#preview))
- Distro: Void Linux
- DM: N/d (for now) 
- WM (Compositor): Sway (and its stack) + Waybar

## Dependencies (so far)
Please note that the package names used here are the ones found in the Void Linux package registry. Doing the same setup in other distros WILL require attention and care when installing the packages listed bellow.

### Compilers and Interpreters
- `lua`
- `go`
- `rustc` - Via [`rustup`](https://www.rust-lang.org/learn/get-started)

### Core
- `git`
- `cmake`
- `wget`
- `curl`
- `dbus`
- `elogind`
- `mesa`
- `mesa-intel-dri`
- `mesa-vulkan-intel`
- `pulseaudio`
- `dejavu-fonts-ttf`
- `font-awesome`
- `font-awesome6`
- `swayfx`
- `swww`
- `SwayNotificationCenter`
- `swaylock-effects` - Via AUR or manual build
- `swayidle`
- `Waybar`
- `eww` - Manually built
- `ghostty`
- `fuzzel`

### Utilities
- `xdg-user-dirs`
- `brightnessctl`
- `pamixer`
- `pavucontrol`
- `power-profiles-daemon`
- `starship` - Via [starship.rs](https://starship.rs/)
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
- [x] Reorganize this repo
- [ ] Deprecate `dotfile_helper`
- [ ] Rethink how theme switching should work
- [ ] Add independent menus
    - [ ] Power menu
- [ ] Config `fastfetch`

## Preview
![Empty workspace](./docs/empty.png)
