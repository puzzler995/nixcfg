{self, lib, modulesPath, ...}: {
  imports = [
    self.nixosModules.disko-btrfs-subvolumes-with-swap
    self.nixosModules.hardware-common
    "${modulesPath}/profiles/qemu-guest.nix"
    self.nixosModules.locale-en-us
  ];

  boot.initrd.availableKernelModules = 
    [
      "ahci"
      "xhci_pci"
      "virtio_pci"
      "sr_mod"
      "virtio_blk"
    ]

  
  boot.kernelPackages = pkgs.linuxPackages_latest;

  diskManager.installDrive = "/dev/vda";

  networking = {
    hostName = "attlerock";
    useDHCP = lib.mkDefault true;
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
      common.enable = true;
    };

    programs = {
      nix.enable = true;
      systemd-boot.enable = true;
    };
  };
}