{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";
  home.username = "cypherlock";
  home.homeDirectory = "/home/cypherlock";

  # Dotfiles
  # home.file.".config/nvim".source = ../nvim;
  # home.file.".config/nvim".source = ../nvim;
  # home.file.".config/tmux".source = ../tmux;
  # home.file.".config/opencode".source = ../opencode;

  home.packages = with pkgs; [
    # Languages and compilers
    go
    gcc
    rustc
    rustup
    nodejs
    python3

    # Lua basics
    lua
    stylua
    luarocks
    lua-language-server

    # utilities
    fzf
    yazi
    unzip
    zoxide
    ripgrep
    starship
    fastfetch
    tree-sitter

    # Nix language support
    nil
    nixpkgs-fmt

    # Dev workflow
    foot
    neovim
    opencode

    # Misc
    prismlauncher
    steam-unwrapped
  ];
}
