{
  config,
  self,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home.nix
    ./secrets.nix
    self.nixosModules.disko-btrfs-subvolumes-with-swap
    self.nixosModules.hardware-amd-cpu
    self.nixosModules.hardware-common
    self.nixosModules.hardware-corsair-keyboard
    self.nixosModules.hardware-nvidia-gpu
    self.nixosModules.hardware-steelseries-headset
    self.nixosModules.hardware-utechvenus-mouse
    self.nixosModules.locale-en-us
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "uas" "usb_storage" "usbhid" "sd_mod"];

  diskManager.installDrive = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S6B0NL0T933139R";

  networking = {
    hostName = "timberhearth";
    useDHCP = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    nix-alien
    #sm64ex
  ];
  programs.nix-ld.enable = true;

  system.stateVersion = "25.05";
  time.timeZone = "America/New_York";

  userManager = {
    kat = {
      enable = true;
      password = "$y$j9T$fXCNJ5L3S4.VfMhNbw3V31$n8k8chfUm8pKn5rbscHhbpDhvcq7JZJNxF9MMDfXUB3";
    };
  };
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  nixOSManager = {
    desktop.cosmic.enable = true;

    profiles = {
      autoUpgrade.enable = true;
      btrfs = {
        enable = true;
        deduplicate = true;
      };
      common.enable = true;
    };

    programs = {
      nix.enable = true;
      obs = {
        enable = true;
        nvidia.enable = true;
      };
      steam.enable = true;
      systemd-boot.enable = true;
    };

    services = {
      tailscale.enable = true;
      cosmic-greeter = {
        enable = true;
        autoLogin = "kat";
      };
    };
  };
}
