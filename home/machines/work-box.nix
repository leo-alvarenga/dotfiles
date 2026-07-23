
{ pkgs, ... }:
{
  home.username = "lasilva";
  home.homeDirectory = "/home/lasilva";

  imports = [
    ../default.nix
    ../modules/dev.nix
  ];
}
