{
  description = "Kat's Homelab and Device flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Nix Formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      disko-btrfs-subvolumes = ./modules/nixos/disko/btrfs-subvolumes;
      disko-btrfs-subvolumes-with-swap = ./modules/nixos/disko/btrfs-subvolumes-with-swap;
      disko-ext4 = ./modules/nixos/disko/ext4;
      hardware-amd-cpu = ./modules/nixos/hardware/amd/cpu;
      hardware-common = ./modules/nixos/hardware/common;
      hardware-corsair-keyboard = ./modules/nixos/hardware/corsair/keyboard;
      hardware-intel-cpu = ./modules/nixos/hardware/intel/cpu;
      hardware-nvidia-gpu = ./modules/nixos/hardware/nvidia/gpu;
      hardware-utechvenus-mouse = ./modules/nixos/hardware/utechvenus/mouse;
      locale-en-us = ./modules/nixos/locale/en-us;
      nixos = ./modules/nixos/os;
      users = ./modules/nixos/users;
    };
    nixosConfigurations = {
        nixos-test = self.inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/nixos-test

            self.inputs.disko.nixosModules.disko
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
        };
        solarsystem = self.inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = {
            flake = {
              nixosModules = self.nixosModules;
            };
          };

          modules = [
            ./hosts/solarsystem
            self.inputs.disko.nixosModules.disko
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
        };
        timberhearth = self.inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/timberhearth

            self.inputs.disko.nixosModules.disko
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
        };
    };

    overlays.default = import ./overlays/default.nix {inherit self;};
  };
} 
