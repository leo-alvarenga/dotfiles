#!/bin/bash

# Functions:
set_allow_sudo () {
    echo "Uncomment the line containing: `%wheel ALL=(ALL:ALL) ALL`"
    sleep 3

    EDITOR=vim visudo
    exit
}

internet_con () {
    echo "Setting up internet connection..."

    sudo dhcpcd
    sudo systemctl enable dhcpcd
    sudo systemctl enable NetworkManager

    echo "Run these commands after iwctl starts:"
    echo "1. device list"
    echo "2. station {your device} scan"
    echo "3. station {your device} get-networks"
    echo "4. station {your device} connect {your wlan's SSID} "
    echo "5. exit"
    sleep 4

    sudo systemctl start iwd && iwctl

    echo "[device]" >> /etc/NetworkManager/conf.d/wifi_backend.conf
    echo "wifi.backend=iwd" >> /etc/NetworkManager/conf.d/wifi_backend.conf
}

xorg_install () {
    echo "Installing Xorg as a display server"
    sudo pacman -S xorg-server xorg-xinit xorg-apps mesa
    sudo pacman -S xf86-video-intel

    sudo pacman -S xdg-user-dirs
    xdg-user-dirs-update
}

audio_setup () {
    echo "Audio setup..."
    sudo pacman -S alsa-utils alsa-mixer pulseaudio
}

install_useful_apps () {
    echo "Installing useful apps..."
    sudo pacman -S firefox code bat neofetch htop btop
}

install_programing_langs () {
    echo "Installing Go Compiler, Node.js, NPM, Rust Compiler and Cargo..."
    sudo pacman -S go nodejs npm rustc cargo

    read -p "Include DevOps technologies (Docker, Docker-Swarm, kubectl...) (y/n): " devops
    if [[ $devops == "y" ]]; then
        echo "Installing Docker, docker-compose, docker-swarm, kubectl and helm..."
        sudo pacman -S docker docker-compose docker-swarm kubectl helm
    fi
}

yay_installation () {
    mkdir InstallationResidues && cd InstallationResidues
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

    cd ../..
    rm -rf InstallationResidues
}

zsh_installation () {
    echo "Installing zsh..."
    sudo pacman -S zsh

    echo "Installing Oh-my-zsh!..."
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo "zsh will be ran now. Please, config it as you like and exit it afterwards"
    zsh

    read -p "Was the zsh config menu displayed to you? [y/n]: " zsh_ok
    if [[ $zsh_ok != "y" ]]; then
        echo "Running zsh config menu. Please, config it as you like and exit it afterwards..."
        zsh /usr/share/zsh/functions/Newuser/zsh-newuser-install -f
    fi

    echo "Installing Syntax highlighting and Autosuggestions to zsh..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    echo "Add the items bellow to the `plugins` section of the file that is about to be opened:"
    echo "zsh-syntax-highlighting"
    echo "zsh-autosuggestions"
    sleep 5
}

set_hide_grub () {
    echo ""
    read -p "Hide GRUB menu on boot? [y/n]: " hide_grub
    if [[ $hide_grub == "y" ]]; then
        echo "GRUB menu will now be hidden on boot unless you hold LSHIFT..."
        
        sudo echo "GRUB_FORCE_HIDDEN_MENU=true" >> /etc/default/grub
        wget https://gist.githubusercontent.com/anonymous/8eb2019db2e278ba99be/raw/257f15100fd46aeeb8e33a7629b209d0a14b9975/gistfile1.sh
        sudo cp gistfile1.sh /etc/grub.d/holdshift && rm gistfile1.sh
        sudo chmod a+x /etc/grub.d/holdshift
        grub-mkconfig -o /boot/grub/grub.cfg
    fi
}

set_brazillian_keyboard () {
    echo ""
    read -p "Use brazilian keyboard layout (br-abnt2)? [y/n]: " use_br
    if [[ $use_br == "y" ]]; then
        echo "Setting Brazilian layout..."
        
        sudo echo "Section \"InputClass\"" >> /etc/X11/xorg.conf
        sudo echo "        Identifier \"KeyboardDefaults\"" >> /etc/X11/xorg.conf
        sudo echo "        Option \"XkbLayout\" \"br\"" >> /etc/X11/xorg.conf
        sudo echo "EndSection" >> /etc/X11/xorg.conf
    fi

    mkdir .config/fontconfig
    cat "<match target=\"pattern\">" >> .config/fontconfig/font.conf
    cat "   <test name=\"family\" qual=\"any\">" >> .config/fontconfig/font.conf
    cat "       <string>monospace</string>" >> .config/fontconfig/font.conf
    cat "   </test>" >> .config/fontconfig/font.conf
    cat "   <edit binding=\"strong\" mode=\"prepend\" name=\"family\">"
    cat "       <string>Source Code Pro</string>" >> .config/fontconfig/font.conf
    cat "   </edit>" >> .config/fontconfig/font.conf
    cat "</match>" >> .config/fontconfig/font.conf
}

enable_touch_click () {
    sudo pacman -S xf86-input-libinput

    sudo echo "Section \"InputClass\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
    sudo echo "       Identifier \"touchpad\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
	sudo echo "       Driver \"libinput\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
    sudo echo "       MatchIsTouchpad \"on\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
	sudo echo "       Option \"Tapping\" \"on\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
	sudo echo "       Option \"TappingButtonMap\" \"lmr\"" >> /etc/X11/xorg.conf.d/30-touchpad.conf
    sudo echo "EndSection" >> /etc/X11/xorg.conf.d/30-touchpad.conf
}

reboot_func () {
    echo ""
    echo "The post-installation is complete!"

    echo "Would like to stay here? (Recommended: n)"
    read -p "(y/n): " proceed

    if [[ $proceed != "y" ]]; then
        reboot
    else
        echo "Okay! I'll leave you to it then!"
        echo "Bye!"
    fi
}

su -

# 1. Allow users to use `sudo`
set_allow_sudo

# 2. Setting up internet connection...
internet_con

# 4. Installing Xorg as a display server
xorg_install

# 5. Audio
audio_setup

# 6. Add useful apps
install_useful_apps

# 7. Programing languages and tools
install_programing_langs

# 8. Install yay
yay_installation

# 9. Install zsh and oh-my-zsh
zsh_installation

# 10. Hide grub menu on start up
set_hide_grub

# 11. Enabling brazillian keyboard layout
set_brazillian_keyboard

# 12. Setup touch on laptop's touchpad
enable_touch_click

# 13. Reboot
reboot_func
