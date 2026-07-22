{ pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
  ];


  # First and foremost!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-box";
  networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  time.timeZone = "America/Sao_Paulo";

  # I18n stuff
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # I yearn for the GNOME; Best DE for laptop users such as myself as of mid 2026; I will DIE on this hill
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    alsa.support32Bit = true;
  };

  users.users."cypherlock" = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "cypherlock";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat
    git
    lsd
    less
    curl
    tmux
    wget
    
    # Dev env
    vim

    # Web
    brave
  ];

  # Fonts
  fonts.packages = with pkgs; [
    recursive
    nerd-fonts.noto
    nerd-fonts.jetbrains-mono
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
