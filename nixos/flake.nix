{
  description = "A very basic flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, home-manager, nixpkgs, ... }: {
    nixosConfigurations.nixos-box = nixpkgs.lib.nixosSystem = {
      system = "x86_63-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.cypherlock = import ./home.nix;
            backupFileExtension = "backup";
          }
        }
      ];
    };
  };
}
