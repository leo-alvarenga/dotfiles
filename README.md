# Dotfiles (WIP)

## Current setup ([Preview](#preview))
- Distro: Arch Linux
- DM: `Ly`
- WM (Compositor): Wayland (and its stack) + Waybar

### Motivation
My current goal with this setup is to configure a minimal, beautiful, customizable Graphical environment with a heavy focus on my workflow as a Frontend Developer and DevOps enthusiast.

## Automated setup
To use the automated setup, follow the steps bellow:
1. Install Arch linux
2. Clone this repository
3. Navigate to the newly cloned repo
4. Execute the `./setup/post_install.sh` script, following its steps and providing it with any info asked about me

## Dependencies (so far)
Please note that the package names used here are the ones found in the Arch Linux package registry unless explictly marked as otherwise. Doing the same setup in other distros WILL require attention and care when installing the packages listed bellow.

### Compilers, Interpreters and Runtimes
- `lua`
- `gcc`
- `make`
- `cmake`
- `go`
- `rustc` - Via [`rustup`](https://www.rust-lang.org/learn/get-started)
- `nodejs` - Via [`nvm`](https://github.com/nvm-sh/nvm)

### Core
- `git`
- `wget`
- `curl`

### Drivers
- `mesa`

### Services
- `bluez`
    - Bluetooth management
    - In Void Linux, this package already includes `bluez-utils` and, by extension, `bluetoothctl`
- `iwd`
- `pulseaudio`
    - Audio device abstraction
- `power-profiles-daemon`
    - Daemon for managing power consumption profiles
    - Options and availability may vary depending on Kernel config, version and Hardware specifications

### Fonts
- `dejavu-fonts-ttf`
- `otf-font-awesome`

### Graphical environment/session
- `ly`
    - TUI based Display manager
- `hyprland`
    - Backbone of the GE
- `swww`
    - Wallpaper management daemon
- `dunst`
    - Notification center
- `hyprlock`
    - Lock screen for the current session
- `hypridle`
    - Idle state manager
- `waybar`
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
- `bat`
    - `cat`-like utility to print to stdout text with out-of-the-box syntax highlighting and pagination with vim-motions (for long files)
- `ripgrep`
    - For recurcevly searching directories for a regex pattern
- `fd-find`
    - Simpler and faster alternative to `find`

### Utilities
- `fastfetch`
    - Customizable system info fetcher
- `grim`
    - Versatile CLI based screencapturing tool
- `flameshot`
    - Screecapturing tool
    - Consumes `grim` internally to capture screenshot
- `nwg-bar`
    - Customizable GTK+3 based power menu
- `fuzzel`
    - GTK+3 based GUI launcher
    - Allows for fuzzy-finding Desktop entries and executing commands
- `iwmenu`
    - Manually built
    - Simple `iwd` wrapper to manage wireless connections in a GUI
    - Requires launcher that provides a `stdin` mode
- `helix`
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
- [x] Rethink how theme switching should work
- [x] Abstract and automate theme switching with scripts
- [x] Move away from Sway in favor of Hyper utils
    - [x] Replace Sway with Hyprland
    - [x] Replace `swayidle` with `hypridle`
    - [x] Replace `swaylock` with `hyprlock`
- [x] Add independent menus
    - [x] Power menu
    - [x] Customize Power menu
- [x] Deprecate `dotfile_helper`
- [ ] Config `fastfetch`

## Preview

[!image1](./docs/catppuccin_hyper1.png)
[!image2](./docs/catppuccin_hyper2.png)

