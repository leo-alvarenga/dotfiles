{ pkgs, ... }:
{
  # Gaming packages
  home.packages = with pkgs; [
    prismlauncher steam-unwrapped
  ];
}
