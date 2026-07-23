{ lib, pkgs, ... }:
{
  home.stateVersion = "26.05";

  # Home packages
  home.packages = with pkgs; [
    fzf
    # cava -> Ill prob do smth fun with this later
    yazi
    unzip
    zoxide
    ripgrep
    starship
    fastfetch
  ];
}
