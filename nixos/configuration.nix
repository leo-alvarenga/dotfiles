# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "br";

    displayManager = {
      sddm = {
        enable = true;
	theme = "${(pkgs.fetchFromGitHub {
          owner = "MarianArlt";
          repo = "kde-plasma-chili";
          rev = "a371123959676f608f01421398f7400a2f01ae06";
          sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
        })}";
      };
      defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
    };
  };

  services.picom = {
    enable = true;
    activeOpacity  = 1.0;
    inactiveOpacity = 0.8;
    backend = "glx";
    vSync = true;
    fade = true;

    opacityRules = [
      "100:class_g = 'firefox'"
      "95:class_g = 'vscodium'"
      "95:class_g = 'code'"
      "90:class_g = 'discord'"
      "80:class_g = 'Alacritty'"
      "80:class_g = 'kitty'"
    ];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    duce = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basics
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    wget
    btop
    xdg-user-dirs
    alsa-utils
    pulsemixer
    acpi
    brightnessctl

    # wm
    picom

    # useful/misc tools
    feh
    imagemagick
    scrot
    kitty
    neofetch
    bat
    lolcat
    cowsay
  ];

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      jetbrains-mono
      fira-code
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Jetbrains Mono" ];
      };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

