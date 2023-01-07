{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "duce";
  home.homeDirectory = "/home/duce";

  home.file = {
    ".config/awesome" = {
      recursive = true;
      source = ../../Repos/dotfiles/.config/awesome/wavy;
    };
    ".config/alacritty" = {
      recursive = true;
      source = ../../Repos/dotfiles/.config/alacritty/wavy;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  home.packages = [
    # development
    pkgs.alacritty
    pkgs.git
    pkgs.vscodium
    pkgs.go
    pkgs.nodejs
    pkgs.gcc

    # utilities
    pkgs.firefox    

    # unfree
    pkgs.steam
  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "Leonardo A. Alvarenga";
      userEmail = "leosgalvarenga@protonmail.com";
    };
  };
}
