{ pkgs, ... }:
{
  # Home packages
  home.packages = with pkgs; [
    gapless # audio player
    picard # organize
    lrcget # fetch lyrics

    nicotine-plus # Soulseek client "󰨈 Rawr"
  ];
}
