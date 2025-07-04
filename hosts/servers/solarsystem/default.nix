{
  self,
  lib,
  ...
}: {
  imports = [
    ./home.nix
    ./secrets.nix
    self.nixosModules.disko-ext4
    self.nixosModules.hardware-common
    self.nixosModules.hardware-intel-cpu
    self.nixosModules.locale-en-us
  ];

  boot.initrd.availableKernelModules = ["uhci_hcd" "ehci_pci" "ata_piix" "megaraid_sas" "usb_storage" "usbhid" "sd_mod" "sr_mod"];

  diskManager.installDrive = "/dev/disk/by-id/scsi-36848f690e5294c002ebc189916656afa";

  microvm = {
    autostart = [
      "attlerock"
    ];
    vms = {
      attlerock = {
        flake = self;

        updateFlake = "github:puzzler995/nixcfg"
      }
    };
  };

  networking = {
    hostName = "solarsystem";
    useDHCP = lib.mkDefault true;
    useNetworkd = true;
  };

  systemd.network = {
    enable = true;

    networks = {
      "10-lan" = {
        matchConfig.Name = ["eno1" "vm-*"];
        networkConfig = {
          Bridge = "br0";
        };
      };

      "10-lan-bridge" = {
        matchConfig.Name = "br0";
        networkConfig = {
          Address = ["192.168.1.200/24"];
          Gateway = "192.168.1.1";
          DNS = ["192.168.1.1"];
        };
        linkConfig.RequiredForOnline = "routeable";
      };
    };

    netdevs = {
      "br0" = {
        netdevConfig = {
          Name = "br0";
          Kind = "bridge";
        };
      };
    };
  };

  system.stateVersion = "25.05";
  time.timeZone = "America/New_York";

  userManager = {
    kat = {
      enable = true;
      password = "$y$j9T$fXCNJ5L3S4.VfMhNbw3V31$n8k8chfUm8pKn5rbscHhbpDhvcq7JZJNxF9MMDfXUB3";
    };
  };

  nixOSManager = {
    profiles = {
      autoUpgrade.enable = true;
      common.enable = true;
    };

    programs = {
      nix.enable = true;
      systemd-boot.enable = true;
    };

    services = {
      tailscale.enable = true;
    };
  };
}
