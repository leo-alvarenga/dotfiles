{ pkgs, ... }:
{
  # Home packages
  home.packages = with pkgs; [
    qbittorrent # torrent client  

    picard # organize

    lrcget # fetch lyrics
    gapless # audio player

    nicotine-plus # Soulseek client "󰨈 Rawr"
  ];
}
