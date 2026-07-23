{ lib, pkgs, ... }:

with lib.hm.gvariant;

{
  home.stateVersion = "26.05";
  home.username = "cypherlock";
  home.homeDirectory = "/home/cypherlock";

  # Dconf settings - Generated with dconf2nix
  dconf = {
    enable = true;

    settings = {
      "org/gnome/Console" = {
        last-window-maximised = true;
        last-window-size = mkTuple [ 732 528 ];
      };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [];
        mru-sources = [ (mkTuple [ "xkb" "us" ]) ];
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "br" ]) ];
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/notifications" = {
        application-children = [ "gnome-power-panel" "gnome-about-panel" ];
      };

      "org/gnome/desktop/notifications/application/gnome-about-panel" = {
        application-id = "gnome-about-panel.desktop";
      };

      "org/gnome/desktop/notifications/application/gnome-power-panel" = {
        application-id = "gnome-power-panel.desktop";
      };

      "org/gnome/desktop/peripherals/keyboard" = {
        numlock-state = false;
      };

      "org/gnome/nautilus/preferences" = {
        migrated-gtk-settings = true;
        default-folder-viewer = "list-view";
      };

      "org/gnome/nautilus/window-state" = {
        initial-size = mkTuple [ 890 550 ];
      };

      "org/gnome/shell" = {
        welcome-dialog-last-shown-version = "50.2";
        last-selected-power-profile = "power-saver";
        favorite-apps = [ "brave-browser.desktop" "footclient.desktop" "org.gnome.Nautilus.desktop" ];
      };

      "org/gnome/shell/world-clocks" = {
        locations = [];
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        show-hidden = true;
      };

    };
  };

  # Home packages
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
    # cava -> Ill prob do smth fun with this later
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

    # Misc
    prismlauncher
    steam-unwrapped
  ];
}
