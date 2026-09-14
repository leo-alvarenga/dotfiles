{ pkgs, ... }:
{
  # Home packages
  home.packages = with pkgs; [
    freac # convert
    picard # organize
    lrcget # fetch lyrics
  ];
}
