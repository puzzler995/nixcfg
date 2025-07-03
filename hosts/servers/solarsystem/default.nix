{
  flake,
  lib,
  ...
}: {
  imports = [
    flake.nixosModules.disko-ext4
    flake.nixosModules.hardware-common
    flake.nixosModules.hardware-intel-cpu
    flake.nixosModules.locale-en-us
  ];

  boot.initrd.availableKernelModules = ["uhci_hcd" "ehci_pci" "ata_piix" "megaraid_sas" "usb_storage" "usbhid" "sd_mod" "sr_mod"];

  diskManager.installDrive = "/dev/disk/by-id/scsi-36848f690e5294c002ebc189916656afa";

  networking = {
    hostName = "solarsystem";
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

    services = {
      #tailscale.enable = true;
    };
  };
}
