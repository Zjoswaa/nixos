{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-patched.url = "github:baracoder/nixpkgs/rider-fix-jcef";
  };

  outputs = { nixpkgs, nur, home-manager, nixpkgs-patched, ... }@inputs: {
    nixosConfigurations.legion = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        ({ pkgs, ... }: {
          nixpkgs.overlays = [
            nur.overlays.default
          ];
        })

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            # ADD THIS LINE: Pass inputs to home.nix
            extraSpecialArgs = { inherit inputs; };
            users.joshua = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
