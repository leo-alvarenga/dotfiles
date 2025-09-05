# Dotfiles (WIP)

## Current setup ([Preview](#preview))
- Distro: Void Linux
- DM: None 
- WM (Compositor): Sway (and its stack) + Waybar

### Motivation
My current goal with this setup is to configure a minimal, yet beautiful and customizable Graphical environment with as few dependencies as possible without resorting Gentoo and other similarly *de-bloatable* distros.

**Hot take**: Yes, Arch and Arch-based distro tend to bring more dependencies (even in more minimal setups) unless the user starts relying mostly on manual builds (which defeats the purpose of this project). Also, I really like Void and its `xbps` package manager

## Dependencies (so far)
Please note that the package names used here are the ones found in the Void Linux package registry unless explictly marked as otherwise. Doing the same setup in other distros WILL require attention and care when installing the packages listed bellow.

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

### Drivers
- `mesa`
- `mesa-intel-dri`
- `mesa-vulkan-intel`

### Libs
- `pam-devel`
    - Required by `swaylock-effects`

### Services
- `dbus`
- `iwd`
- `elogind`
    - Session and seat management
- `pulseaudio`
    - Audio device abstraction
- `power-profiles-daemon`

### Fonts
- `dejavu-fonts-ttf`
- `font-awesome`
- `font-awesome6`

### Graphical environment/session
- `swayfx`
    - Backbone of the GE
    - Fork of the original
- `swww`
    - Wallpaper management daemon
- `SwayNotificationCenter`
    - Notification center
    - Also provides a GTK+3 based GUI
- `swaylock-effects`
    - **Manually built**
    - Lock screen for the current session
- `swayidle`
    - Idle state manager
- `Waybar`
    - Status bar

### Config management (CLI, TUI or GUI based)
- `brightnessctl`
    - Daemon-less screen brightness control via CLI
- `pamixer`
    - Audio device control via CLI
- `pavucontrol`
    - Audio device control via GUI (GTK+3 based)

### Quality of Life (QoL)
- `xdg-user-dirs`
    - Used to create and manage user directories in a standardized way
- `wl-clipboard`
    - Basic clipboard for Compositors implemented following the Wayland protocol
- `chafa`
    - CLI utility to print and display images directly within the terminal using the kitty graphics protocol
    - Can also convert images into ASCII or colored character art

### Shell utilities
- `starship` - Installed via [starship.rs](https://starship.rs/)
    - Feature-rich, performant and customizable shell prompt
- `btop`
    - Process and performance TUI monitor
- `tree`
    - Utility to print directories and files hierarchicaly in a human-readable way

### Utilities
- `fastfetch`
    - Customizable system info fetcher
- `slurp`
    - Utility to visually select a region on a screen in Wayland compositors
- `grim`
    - Versatile CLI based screencapturing tool
- `wlogout`
    - Customizable GTK+3 based power menu
- `fuzzel`
    - GTK+3 based GUI launcher
    - Allows for fuzzy-finding Desktop entries and executing commands
- `iwmenu`
    - Manually built
    - Simple `iwd` wrapper to manage wireless connections in a GUI
    - Requires launcher that provides a `stdin` mode
- `neovim`
    - Code editor of choice
- `ghostty`
    - Feature-rich, performant and customizable shell emulator

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
- [x] Add independent menus
    - [x] Power menu
    - [ ] Customize Power menu <
- [x] Rethink how theme switching should work
- [ ] Abstract and automate theme switching with scripts
- [ ] Deprecate `dotfile_helper`
- [ ] Config `fastfetch`

## Preview

### Rose pine
![Fetch rose-pine](./docs/rose_pine_empty.png)
![Neovim rose-pine](./docs/rose_pine_neovim.png)

### Gruvbox dark
![Empty gruvbox dark](./docs/gruvbox_dark_empty.png)
![Fetch gruvbox dark](./docs/gruvbox_dark_fetch.png)
![Neovim gruvbox dark](./docs/gruvbox_dark_neovim.png)
