#!/bin/bash

internet_con () {
    echo "Run these commands after iwctl starts:"
    echo "1. device list"
    echo "2. station {your device} scan"
    echo "3. station {your device} get-networks"
    echo "4. station {your device} connect {your wlan's SSID} "
    echo "5. exit"

    iwctl
}

rewrite_partitions () {
    echo "Rewriting the partition table"
    echo ""

    echo "Your partitions should look like this:"
    echo " - Partition 1: 500M, Boot/EFI Partition"
    echo " - Partition 2: 2G-6G (Depening on RAM size), Linux/Solaris SWAP"
    echo " - Partition 3: 40G, Linux (root)"
    echo " - Partition 4: Remaining disk, Linux (home)"

    sleep 4

    read -p "Use cfdisk instead of fdisk to write the partitions (recommended: y)? [y/n]: " use_cfdisk

    if [[ $use_cfdisk == "y" ]]; then
        fdisk
    else
        cfdisk
    fi
}

format_partitions () {
    mkfs.fat -F32 /dev/sda1
    mkswap /dev/sda2
    mkfs.ext4 /dev/sda3
    mkfs.ext4 /dev/sda4
}

mount_partitions () {
    echo "Mouting /dev/sda3 (root) to /mnt"
    mount /dev/sda3 /mnt

    echo "Creating /home and /boot on /mnt"
    mkdir /mnt/home && mkdir /mnt/boot

    echo "Mouting /dev/sda1 to /mnt/boot"
    mount /dev/sda1 /mnt/boot

    echo "Mouting /dev/sda4 to /mnt/home"
    mount /dev/sda4 /mnt/home

    echo "Activating swap on /dev/sda2"
    swapon /dev/sda2
        
    echo "Check if everything is okay:"
    lsblk
}

update_mirrorlist () {
    echo "Updating package list..."
    pacman -Syy # Update package lists

    echo "Installing reflector"
    pacman -S reflector

    echo "Creating a mirrorlist backup"
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

    echo "Setting up a new mirrorlist"
    reflector -c "BR" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
}

reboot_func () {
    echo ""
    echo "The installation is complete!"

    echo ""
    read -p "Would like to stay here? (Recommended: n) [y/n]: " proceed

    if [[ $proceed != "y" ]]; then
        reboot
    else
        echo "Okay! I'll leave you to it then!"
        echo ""
    fi
}

printf "Leo's Arch Linux installation script\n\n"

# Installing Arch:

# 1. Download ISO
# 2. Make bootable USB Stick from ISO
# 3. Reboot and plug USB Stick
# 4. Open BIOS Menu (F10-F12, not sure)
# 5. Set Boot mode to Legacy, instead of UEFI (for some reason, UEFI does not work w/ arch on my PC)
# 6. Boot from USB to install
# 7. Load brazilian keyboard layout for the session
loadkeys br-abnt2

# 8. (Optional) Connect to internet via Wifi
internet_con

# 9. Use `cfdisk` or `fdisk` to write partitions
rewrite_partitions

# 10. Format partitions:
format_partitions

# 11. Mount partitions:
mount_partitions

# 12. Get the best mirrors to download large packages from based on location (Brazil):
update_mirrorlist

# 13. _Pacstrap_ the new system:
echo "Pacstraping the new system:"
pacstrap /mnt base base-devel linux linux-firmware nano vim dhcpcd

# 14. Generate FSTAB
echo "Generating a FSTAB"
genfstab -U -p /mnt >> /mnt/etc/fstab

# 15. Change into the system itself: `arch-chroot /mnt`
echo "Changing into the new system:"
arch-chroot /mnt

# 16. Setup date and time:

echo "Data and Time (Using Sao Paulo)"
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
date

# 17. Set locale:
echo "Uncomment lines starting with pt_BR"
sleep 1

vim /etc/locale.gen
locale-gen
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf

# 18. Set passwords and users:
echo "Setup root password:"
passwd

read -p "What will be your username? > " username
useradd -m -g users -G wheel,storage,power -s /bin/bash "$username"
passwd "$username"

# 19. Install useful packages:
echo "Installing packages"
pacman -S dosfstools os-prober mtools network-manager-applet networkmanager wpa_supplicant wireless_tools dialog grub wget
pacman -S iwd

# 20. Install grub:
echo "Installing grub"
grub-install --target=i386-pc --recheck /dev/sda

# 21. Enable the use of Os-prober, to enable scaning of ALL partitions and ensure grub works as intended:
echo ""
echo "Uncomment the line regarding Os-prober (Usually the last one)"
sleep 2
vim /etc/default/grub

# 22. Generate grub config:
echo "Generating grub config"
grub-mkconfig -o /boot/grub/grub.cfg

# 23. Reboot
reboot_func
