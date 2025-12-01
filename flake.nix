{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        thinkpad-t14-amd-gen3 = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/thinkpad-t14-amd-gen3/configuration.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen3
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.nghia = import ./home.nix;

            }
          ];
        };

        dell-precision-t3600 = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/dell-precision-t3600/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.nghia = import ./home.nix;

            }
          ];
        };
      };

      homeConfigurations."nghia" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./hosts/ubuntu-wsl/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
