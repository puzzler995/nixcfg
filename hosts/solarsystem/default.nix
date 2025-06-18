{config, self, lib, ...
}: {
  imports = [
    ./configuration.nix

    self.nixosModules.disko-ext4
    self.nixosModules.hardware-common
    self.nixosModules.hardware-intel-cpu
    self.nixosModules.locale-en-us
  ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "megaraid_sas" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];

  diskManager.installDrive = "/dev/disk/by-id/scsi-36848f690e5294c002ebc189916656afa";

  networking = {
    hostName = "solarsystem";
    useDHCP = lib.mkDefault true;
  };

  system.stateVersion = "25.05";
  time.timeZone = "America/New_York";

  userManager.kat.enable = true;

  nixOSManager = {
    profiles = {
      base.enable = true;
    };

    programs = {
      systemd-boot.enable = true;
    };
  };
}