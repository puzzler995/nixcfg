{
  description = "A simple NixOS flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    #home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    #Helix Editor
    helix.url = "github:helix-editor/helix/master";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, ... }: let 
    allSystems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f:
      self.inputs.nixpkgs.lib.genAttrs allSystems (system: 
      f {
        pkgs = import self.inputs.nixpkgs {
          inherit overlays system;
          config.allowUnfree = true;
        };
      });

      forAllLinuxHosts = self.inputs.nixpkgs.lib.genAttrs [
        "gabbro"
        "timberhearth"
        "solarsystem"
        "nixos-test"
      ];
      overlays = [
        self.overlays.default
      ];
  in {
    nixosModules = {
      locale-en-us = ./modules/nixos/locale/en-us;
      users = ./modules/nixos/users;
    };

    nixosConfigurations = forAllLinuxHosts (
      host:
        self.inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/${host}

            self.inputs.home-manager.nixosModules.home-manager
            self.inputs.lix-module.nixosModules.default
            self.nixosModules.users

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }

          ];
        }
    );
  };
} 
