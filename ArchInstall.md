# Archlinux installation

I decided to replace my old scripts with this doc as it was becoming a little awkward to maintain them as I kept jumping from WM to WM.

Bear in mind that the following steps assume you already configured an installation medium (_e.g_: bootable usb stick) and has already booted up from it.

## Basic installation
<details>
    <summary>See</summary>

  ### Steps
  0. [Keyboard layout](#0-set-keyboard-layout)
  1. [Internet connection](#1-connect-to-the-internet)
  2. [Rewrite partitions](#2-rewrite-your-partitions)
  3. [Format your new partitions](#3-format-your-partitions)
  4. [Mount your partitions](#4-mount-your-partitions)
  5. [Update your mirrorlist](#5-update-your-mirrorlist)
  6. [Pacstrap your new system](#6-pacstrap-your-new-system)
  7. [Generate a filesystem table](#7-generate-a-filesystem-table)
  8. [Enter in your system](#8-enter-in-your-system)
  9. [Setup date and locale](#9-setup-date-and-locale)
  10. [Setup your user](#10-setup-your-user)
  11. [Install essentials](#11-installing-essentials)
  12. [Install and prep grub](#12-install-and-prep-grub)
  13. [Reboot](#13-reboot)
  14. [Allow sudo use](#14-allow-sudo)
  15. [Setup internet connection](#15-setup-internet-connection)
  16. [Audio and video setup](#16-audio-and-video-setup)
  17. (Optional) [Install an AUR helper](#17-installing-an-aur-helper)


</details>


## Post install (Graphical interface setup)
<details>
    <summary>See</summary>

  ### Steps
  1. [Install a display server](#1-install-a-display-server)
    1.1 [Install Xorg](#11-xorg-installation)
    1.2 [Install Wayland](#12-wayland-installation)

</details>
<br>

## 0. Set keyboard layout
It is important to set your keyboar layout as your installation medium defaults to `us`.

Do this by running:
```bash
loadkeys <your keyboard layout>

# In my case:
# loadkeys br-abnt2
```

## 1. Connect to the internet
If you are connected with cable, you should already have internet connection.

Otherwise, run:
1. `iwctl`
2. `device list`
3. `station <your device from before here> get-networks`
4. `station <your device from before here> connect "<your wifi's name/essid>"`
5: `exit`

After that, test you connection:
```bash
ping -c 2 wiki.archlinux.org
ping -c 2 google.com
```

## 2. Rewrite your partitions

Use `fdisk` or `cfdisk` (I recommend the later) to rewrite your partitions in the following manner:

- Partition 1: 500M, Boot/EFI Partition
- Partition 2: 2G-6G (Depening on RAM size), Linux/Solaris SWAP
- Partition 3: 20G-40G, Linux (root)"
- Partition 4: Remaining disk, Linux (home)"

## 3. Format your new partitions
Run:

```bash
mkfs.fat -F32 /dev/sda1 &&
mkswap /dev/sda2 &&
mkfs.ext4 /dev/sda3 &&
mkfs.ext4 /dev/sda4 &&
```

## 4. Mount your partitions
Run this if you intend to use Arch in EFI/Legacy mode:

```bash
mount /dev/sda3 /mnt &&
mkdir /mnt/home && 
mkdir /mnt/boot &&
mount /dev/sda1 /mnt/boot &&
mount /dev/sda4 /mnt/home &&
swapon /dev/sda2
```

Otherwise, refer to the wiki.

## 5. Update your mirrorlist
To do this, I usually use a tool called `reflector`, that saves to a file a list of the known Arch package repositories that had the lowest response time to your machine's requests.

To do that, run:
```bash
# Copy one at a time
pacman -Syy

pacman -S reflector

# creating a backup
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

# change it your countries initials, e.g: for me, it's BR
reflector -c "<your country>" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

## 6. Pacstrap your new system
This will install the bar minimal, plus a few useful tools, to use your new system:

```bash
pacstrap /mnt base base-devel linux linux-firmware vim dhcpcd

# replace vim with your favorite cli-based editor
```

## 7. Generate a filesystem table
```bash
genfstab -U -p /mnt >> /mnt/etc/fstab
```

## 8. Enter in your system
Enter in your freshly installed system to finish the setup:

```bash
arch-chroot /mnt
```

## 9. Setup date and locale
```bash
ln -sf /usr/share/zoneinfo/<your zone>/<a city> /etc/localtime

# e.g: ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

hwclock --systohc
date
```

Now, run `vim /etc/locale.gen`, uncomment the lines starting with your languages' initials and run `locale-gen`.

Additionally, run `echo KEYMAP=br-abnt2 >> /etc/vconsole.conf` to set your keyboard layout for `tty`.

## 10. Setup your user
Run:

```bash
# setup a password for the root user
passwd

# create a setup your user
useradd -m -g users -G wheel,storage,power -s /bin/bash <your username>
passwd <your username>
```

## 11. Installing essentials
```bash
pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog grub wget

# if you intent to use wifi, I recommend running this as well:
pacman -S iwd
```
## 12. Install and prep grub
This will only work properly if you intend to boot your system in EFI/Legacy mode, otherwise refer to the wiki.

1. `grub-install --target=i386-pc --recheck /dev/sda`
2. Uncomment the line regarding the disabling of `os-prober` in `/etc/default/grub`
3. Run `grub-mkconfig -o /boot/grub/grub.cfg`

## 13. Reboot
Reboot, remove the installation medium and boot into your new system

```bash
reboot
```

## 14. Allow sudo
```bash
# after login, run 
su -

# uncomment the line containing: `%wheel ALL=(ALL:ALL) ALL`
EDITOR=<your editor> visudo
exit
```

## 15. Setup internet connection
```bash
sudo dhcpcd
sudo systemctl enable dhcpcd
sudo systemctl enable NetworkManager

# if you need to connect to wifi, run
sudo systemctl start iwd && iwctl
```

Now run `<your editor> /etc/NetworkManager/conf.d/wifi_backend.conf` and add the following config to it:

```ini
[device]
wifi.backend=iwd
```

## 16. Audio and video setup
It makes sense to able to control your audio and screen (if you are in a laptop), for that, run:

```bash
sudo pacman -S alsa-utils alsa-mixer pulseaudio

# add brightnessctl to the mix if you want control over your laptop's screen brightness
```

## 17. (Optional) Install an AUR helper
Many packages are not officially distributed by Arch, needing either a manual build or having package builds mainained by normal users in the AUR.

Although you can always just clone the AUR repo you want and install the package in question with `makepkg -si`, it is a good idea to have a reliable helper to automatically do that for you.

I like to use `yay`, and to install it, run:

```bash

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

cd ..
rm -rf yay
```

---
# Post install

## 1. Install a display server
First of all, decide which display server you would like to use:

- X11 (Xorg solution; Ubuntu and Linux Mint and Ubuntu-based distros are shipped with Xorg)
  - (+) very reliable 
  - (-) old
  - (-) not particularly efficient
- Wayland (Fedora is shipped with Wayland since v8)
  - (+) Fast, modern and overall better looking
  - (-) Some applications might need additional setup (_e.g_: Steam, electron-based apps, such as VS Code, Discord, Spotify)
  - (-) A few applications are straight up not supported

## 1.1. Xorg installation

```bash
sudo pacman -S xorg-server xorg-xinit xorg-apps mesa

# change this with your driver
sudo pacman -S xf86-video-intel
```

## 1.2. Wayland installation

```bash
sudo pacman -S wayland wayland-protocols wayland-utils mesa

# change this with your driver
sudo pacman -S xf86-video-intel
```

## 2. DE or WM install

Now, for the actual environment, you go with whatever makes you happy.

In this very repository, you can obtain configs for two different Xorg compatible tiling window managers, [`awesomewm`](https://github.com/awesomeWM/awesome) and [`bspwm`](https://github.com/baskerville/bspwm).

There are also a lot of different Compositors for Wayland, that perform the same way a traditional Xorg WM does. From those, I recommend [`Hyprland`](https://github.com/hyprwm/Hyprland) and [`Sway`](https://github.com/swaywm/sway). Bear in mind that Hyprland is still in beta though.

Now, regarding Desktop Environments, in Xorg, you can also install Gnome, KDE Plasma or XFCE4.

While if you installed Wayland and want DE, the recommendation is to use Gnome, as its implementation follows the Wayland protocol architecture to the letter. KDE Plasma is also supported as of version 5.20.
