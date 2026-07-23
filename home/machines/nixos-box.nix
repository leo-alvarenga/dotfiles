
{ pkgs, ... }:
{
  home.username = "cypherlock";
  home.homeDirectory = "/home/cypherlock";

  imports = [
    ../default.nix
    ../modules/dev.nix
    ../modules/gnome.nix
    ../modules/gaming.nix
  ];
}
