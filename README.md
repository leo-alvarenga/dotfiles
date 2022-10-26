# Leo's dotfiles

This repo is meant to be where I store my config files (those usually stored in the `~/.config` directory, hence the name) for my current setup, so that they can be easily retrieved for recovery and to serve as reference for future configurations.

---
# Current Setup

## GNU/Linux
- Kernel: 5.19.13-arch1-1
- Distro: Arch Linux
- Display server: Xorg
- Display manager: LightDM Slick Greeter
- WM: [bspwm 0.9.10](https://github.com/baskerville/bspwm)
- Compositor: Picom ([jonaburg's fork](https://github.com/jonaburg/picom))
- Lock: i3lock (🚧config in progress)
- Shell: Zsh 5.9 (w/ [Oh My Zsh!](https://github.com/ohmyzsh/ohmyzsh))
- Terminal: [Alacritty](https://github.com/alacritty/alacritty)

It is certainly worth noting that although my config files can be found in this repo, they are still subject to change, as I am **always** tinkering with them (specially with the bspwm).

## bspwm

### Tuxpuccin 🐧 - a [catpuccin](https://github.com/catppuccin/catppuccin) inspired setup for bspwm
To use this setup, copy only the `tuxpuccin` directories from `.config/bspwm` and `.config/polybar` to your `~/.config` directory, renaming them to `bspwm` and `polybar`, respectively

![Setup preview](assets/images/bspwm1-1.png)
\
![Setup preview](assets/images/bspwm1-2.png)

## AwesomeWM (No longer maintained)
![Setup preview](assets/images/awesomewm1.png)
\
![Setup preview](assets/images/awesomewm2.png)
