{ pkgs, ... }:
{
  # Dev packages
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

    # Nix language support
    nil
    nixpkgs-fmt

    # utilities
    fzf
    yazi
    unzip
    zoxide
    ripgrep
    starship
    fastfetch
    tree-sitter

    # Dev workflow
    foot
    neovim
    opencode
  ];
}
