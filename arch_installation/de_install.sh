#!/bin/bash

de_installation () {
    read -p "Only KDE Plasma is supported by this script at this point. Does that sound good? [y/n]: " use_plasma

    if [[ $use_plasma == "y" ]]; then
        echo "Installing KDE Plasma's stack, Konsole, and Firefox..."
        sudo pacman -S plasma konsole firefox

        echo "Installing Alacritty with yay. If this does not work, use konsole as your terminal emulator..."
        sleep 1
        yay -S alacritty

        echo "Installing sddm..."
        sudo pacman -S sddm

    else
        echo "Sorry! Bye!"
    fi
}

wm_installation () {
    echo "So you want to use a Tiling Window manager, huh?, Okay, let's see..."
    sleep 1

    read -p "Only AwesomeWM is supported by this script. Does that sound good? [y/n]: " use_awesome

    if [[ $use_awesome == "y" ]]; then
        echo "Installing awesome, dmenu, picom, nitrogen and others..."
        sleep 1
        sudo pacman -S awesome dmenu picom kitty nitrogen pcmanfm vlc xfce4-taskmanager xfce4-power-manager xfce4-settings

        echo "Installing Alacritty with yay. If this does not work, use kitty as your terminal emulator..."
        sleep 1
        yay -S alacritty

        echo "Setting up Awesome to be launched at startup..."
        echo "exec awesome" >> .xinitrc
        echo "start x" >> .xinitrc

        echo "Installing a Display Manager..."
        echo "Which display manager should be installed?"
        echo "(1) lightdm-slick-greeter (same as Linux Mint)"
        echo "(2) lightdm-gtk-greeter (same as Linux Mint)"
        echo "(3) gdm (same as Gnome DM)"
        echo "(4) sddm (Simple Display Manager, based on QML; Recommended when using KDE Plasma or XFCE4"
        echo "(0) None"

        read -p "(Default: 1)" display_manager

        case $display_manager in
            0)
                echo "Skipping..."
            ;;

            2)
                echo "Installing lightdm-gtk-greeter..."
                sudo pacman -S lightdm-gtk-greeter
            ;;

            3)
                echo "Installing gdm..."
                sudo pacman -S gdm
            ;;

            4)
                echo "Installing sddm..."
                sudo pacman -S sddm
            ;;

            *)
                echo "Installing lightdm-slick-greeter..."
                sudo pacman -S lightdm-slick-greeter
            ;;
        esac

        cp /etc/xdg/awesome/rc.lua ./.config/awesome
            
        printf "Ready to roll! Just import your settings!\n\n"
        echo "Happy hacking!"
    else
        echo "Sorry! Bye!"
    fi
}

printf "Leo's Arch Linux Post-Install setup\n\n"

read -p "Do you want to use a Desktop Environment? [y/n]: " use_de

if [[ $use_de != "n" ]]; then
    de_installation
else
    wm_installation
fi
