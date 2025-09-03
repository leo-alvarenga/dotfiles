# Dotfiles (WIP)

## Current setup ([Preview](#preview))
- Distro: Void Linux
- DM: None 
- WM (Compositor): Sway (and its stack) + Waybar

## Dependencies (so far)
Please note that the package names used here are the ones found in the Void Linux package registry. Doing the same setup in other distros WILL require attention and care when installing the packages listed bellow.

### Compilers and Interpreters
- `lua`
- `go`
- `rustc` - Via [`rustup`](https://www.rust-lang.org/learn/get-started)

### Core
- `git`
- `make`
- `gcc`
- `cmake`
- `wget`
- `curl`
- `pam-devel`
- `dbus`
- `iwd`
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
- `swaylock-effects` - Manual build
- `swayidle`
- `Waybar`

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
- `wlogout`
- `iwmenu`
- `ghostty`
- `fuzzel`

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

### Rose pine
![Fetch rose-pine](./docs/rose_pine_empty.png)
![Neovim rose-pine](./docs/rose_pine_neovim.png)

### Gruvbox dark
![Empty gruvbox dark](./docs/gruvbox_dark_empty.png)
![Fetch gruvbox dark](./docs/gruvbox_dark_fetch.png)
![Neovim gruvbox dark](./docs/gruvbox_dark_neovim.png)
