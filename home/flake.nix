{
  description = "Reproducible and portable nix based configuration for my non-NixOS machines";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { home-manager, nixpkgs, ... }: {
    homeConfigurations = {
      lasilva = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./machines/work-box.nix
        ];
      };
    };
  };
}
