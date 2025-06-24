{
  config,
  self,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./secrets.nix
    self.nixosModules.disko-btrfs-subvolumes-with-swap
    self.nixosModules.hardware-amd-cpu
    self.nixosModules.hardware-common
    self.nixosModules.hardware-corsair-keyboard
    self.nixosModules.hardware-nvidia-gpu
    self.nixosModules.hardware-utechvenus-mouse
    self.nixosModules.locale-en-us
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "uas" "usb_storage" "usbhid" "sd_mod"];

  diskManager.installDrive = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S6B0NL0T933139R";

  networking = {
    hostName = "timberhearth";
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

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    discord
    vscode.fhs
  ];

  nixOSManager = {
    desktop.gnome.enable = true;

    profiles = {
      common.enable = true;
    };

    programs = {
      nix.enable = true;
      steam.enable = true;
      systemd-boot.enable = true;
    };

    services = {
      tailscale.enable = true;
    };
  };
}
