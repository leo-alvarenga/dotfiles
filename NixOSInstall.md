# NixOS installation

Bear in mind that the following steps assume you already configured an installation medium with NixOS' minimal installation (_e.g_: bootable usb stick) and has already booted up from it.

## Basic installation
<details>
    <summary>See</summary>

  ### Steps
  0. [Keyboard layout](#0-set-keyboard-layout)
  1. [Internet connection](#1-connect-to-the-internet)
  2. [Rewrite partitions](#2-rewrite-your-partitions)
  3. [Format your new partitions](#3-format-your-partitions)
  4. [Mount your partitions](#4-mount-your-partitions)
  5. [Install NixOS](#5-install-nixos)
  6. [Setup your user](#6-setup-your-user)
  7. [Setup internet connection](#7-setup-internet-connection)

</details>

## Considerations
- The following steps are targeted towards my personal machine, meaning that you might need to deviate a little from it to best fit yours. Do this by following the [NixOS Manual](nixos.org/manual/stable/). 

- The default and root users in the Minimal Installation iso have empty passwords, meaning it's probably a good idea (that is, if you know what you are doing) to run `sudo -i` as your first command.

- If the text is too small, run `setfont ter-v32n` to increase it.

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
1. `systemctl start wpa_supplicant`
2. `wpa_cli` (the following should be done inside the REPL that will result from this command)
	1. `add_network`
	2. `set_network 0 ssid "My network"`
	3. `set_network 0 psk "My super password"`
	4. `set_network 0 key_mgmt WPA-PSK`
	5. `enable_network 0`
	6. `exit`

After that, test you connection:
```bash
ping -c 2 google.com
```

## 2. Rewrite your partitions

Use `parted` or other tools to rewrite your partitions. With NixOS, I use two partitions (Swap and Root) in Legacy Boot.

- Partition 1: (remaining disk), Linux (root)
- Partition 2: 8G, Linux/Solaris SWAP (linux-swap)

The `parted` commands would look like this:

```bash
# write disk as MBR (Legacy boot)
parted /dev/sda -- mklabel msdos 

# create the root partition, taking the entire disk minus the last 8GB
parted /dev/sda -- mkpart primary 1MB -8GB

# allow th disk to be booted from
parted /dev/sda -- set 1 boot on

# create the swap partition, taking the entirity of the last 8GB left
parted /dev/sda -- mkpart primary linux-swap -8GB 100%

```

## 3. Format your new partitions
Run:

```bash
mkfs.ext4 -L NIXOS /dev/sda1 &&
mkswap -L SWAP /dev/sda2
```

## 4. Mount your partitions
```bash
mount /dev/disk/by-label/NIXOS /mnt &&
swapon /dev/sda2
```

## 5. Install NixOS
Now, run `nixos-generate-config --root /mtn` edit it to your liking and run `nixos-intall` to install it.

If everything went okay, reboot your machine.

## 6. Setup your user
Run:

```bash
# nixos-install should already have asked you for the root password
# setup a password for your user
passwd <user>
```

## 7. 
If you are using ethernet as your connection interface, simply enabling the networkmanager in your `configuration.nix` during your install should be enough. 

If you intend to use wifi, what I recommend to do is to enable networkmanager (regardless of the fact that wpa_supplicant is an option) an use `nmcli` to connect to my wireless network.
