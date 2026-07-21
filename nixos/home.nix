{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";
  home.username = "cypherlock";
  home.homeDirectory = "/home/cypherlock";

  home.packages = with pkgs; [
    # Languages and compilers
    go
    gcc
    lua
    cargo
    rustc
    rustup
    nodejs
    python3
    luarocks

    # utilities
    fzf
    yazi
    unzip
    zoxide
    ripgrep
    starship
    tree-sitter

    # Dev workflow
    foot
    neovim
    opencode
  ];
}
