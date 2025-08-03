{
  description = "Kat's Homelab and Device flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pinnedArchipelagoVersion.url = "github:NixOS/nixpkgs/e6f23dc08d3624daab7094b701aa3954923c6bbb";

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
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    katpkgs = {
      url = "github:puzzler995/katpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix = {
      url = "git+https://git.lix.systems/lix-project/lix.git";
      #url = "git+https://git.lix.systems/lix-project/lix.git?ref=release-2.93";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module.git";
      #url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs = {
        lix.follows = "lix";
        nixpkgs.follows = "nixpkgs";
      };
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #--------------------------------------------
    # Non Flake Inputs

    # bizhawk-src = {
    #   url = "github:TASEmulators/BizHawk";
    #   flake = false;
    # };
    # Temporarily jumping to the flake someone made
    bizhawk = {
      url = "github:SignalWalker/BizHawk";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = {self, ...}: let
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
      "attlerock"
    ];
    pinnedArchipelago = final: prev: {
      inherit (self.inputs.pinnedArchipelagoVersion.legacyPackages.${prev.system}) archipelago;
    };
    overlays = [
      self.inputs.nix-alien.overlays.default
      self.inputs.nix-vscode-extensions.overlays.default
      self.inputs.nur.overlays.default
      self.overlays.default
      self.overlays._2ship2harkinian
      self.overlays.sm64ex
      self.overlays.vvvvvv
      pinnedArchipelago
    ];
  in {
    darwinConfigurations = {
      feldspar = self.inputs.nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/laptops/feldspar
          self.darwinModules.default
          self.inputs.home-manager.darwinModules.home-manager
          self.inputs.lix-module.nixosModules.default
          self.inputs.nix-homebrew.darwinModules.nix-homebrew
          self.inputs.sops-nix.darwinModules.default
          {
            home-manager = {
              backupFileExtension = "bak";
              extraSpecialArgs = {inherit self;};
              useGlobalPkgs = true;
              useUserPackages = true;
            };

            nixpkgs = {
              inherit overlays;
              config.allowUnfree = true;
            };
          }
        ];

        specialArgs = {
          inherit self;
        };
      };
    };

    darwinModules.default = ./modules/darwin;

    homeManagerModules = {
      kat = ./homes/kat;
      default = ./modules/home;
    };

    nixosModules = {
      disko-btrfs-subvolumes = ./modules/nixos/disko/btrfs-subvolumes;
      disko-btrfs-subvolumes-with-swap = ./modules/nixos/disko/btrfs-subvolumes-with-swap;
      disko-ext4 = ./modules/nixos/disko/ext4;
      hardware-amd-cpu = ./modules/nixos/hardware/amd/cpu;
      hardware-common = ./modules/nixos/hardware/common;
      hardware-corsair-keyboard = ./modules/nixos/hardware/corsair/keyboard;
      hardware-intel-cpu = ./modules/nixos/hardware/intel/cpu;
      hardware-nvidia-gpu = ./modules/nixos/hardware/nvidia/gpu;
      hardware-steelseries-headset = ./modules/nixos/hardware/steelseries/headset;
      hardware-utechvenus-mouse = ./modules/nixos/hardware/utechvenus/mouse;
      locale-en-us = ./modules/nixos/locale/en-us;
      nixos = ./modules/nixos/os;
      users = ./modules/nixos/users;
    };
    nixosConfigurations = {
      solarsystem = self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit self;
        };

        modules = [
          ./hosts/servers/solarsystem
          self.inputs.disko.nixosModules.disko
          self.inputs.home-manager.nixosModules.home-manager
          self.inputs.lix-module.nixosModules.default
          self.inputs.microvm.nixosModules.host
          self.inputs.sops-nix.nixosModules.sops
          self.nixosModules.nixos
          self.nixosModules.users

          {
            home-manager = {
              backupFileExtension = "bak";
              extraSpecialArgs = {inherit self;};
              useGlobalPkgs = true;
              useUserPackages = true;
            };

            nixpkgs = {
              inherit overlays;
              config.allowUnfree = true;
            };

            sops.defaultSopsFile = ./secrets/secrets.yaml;
          }
        ];
      };
      timberhearth = self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/desktops/timberhearth

          self.inputs.disko.nixosModules.disko
          self.inputs.home-manager.nixosModules.home-manager
          self.inputs.lix-module.nixosModules.default
          self.inputs.sops-nix.nixosModules.sops
          self.nixosModules.nixos
          self.nixosModules.users

          {
            home-manager = {
              backupFileExtension = "bak";
              extraSpecialArgs = {inherit self;};
              useGlobalPkgs = true;
              useUserPackages = true;
            };

            nixpkgs = {
              inherit overlays;
              config.allowUnfree = true;
            };

            sops.defaultSopsFile = ./secrets/secrets.yaml;
          }
        ];

        specialArgs = {
          inherit self;
        };
      };
      attlerock = self.inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit self;
        };

        modules = [
          ./hosts/vms/attlerock
          self.inputs.microvm.nixosModules.microvm
          self.inputs.home-manager.nixosModules.home-manager
          self.inputs.lix-module.nixosModules.default
          self.inputs.sops-nix.nixosModules.sops
          self.nixosModules.nixos
          self.nixosModules.users

          {
            home-manager = {
              backupFileExtension = "bak";
              extraSpecialArgs = {inherit self;};
              useGlobalPkgs = true;
              useUserPackages = true;
            };

            nixpkgs = {
              inherit overlays;
              config.allowUnfree = true;
            };
          }
        ];
      };
    };

    overlays = {
      default = import ./overlays/default.nix {inherit self;};
      _2ship2harkinian = import ./overlays/_2ship2harkinian/default.nix {inherit self;};
      sm64ex = import ./overlays/sm64ex/default.nix {inherit self;};
      vvvvvv = import ./overlays/vvvvvv/default.nix {inherit self;};
    };
  };
}
