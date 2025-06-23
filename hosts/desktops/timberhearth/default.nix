{
  config,
  self,
  pkgs,
  lib,
  ...
}: {
  imports = [
    self.nixosModules.disko-btrfs-subvolumes-with-swap
    self.nixosModules.hardware-amd-cpu
    self.nixosModules.hardware-common
    self.nixosModules.hardware-corsair-keyboard
    self.nixosModules.hardware-nvidia-gpu
    self.nixosModules.hardware-utechvenus-mouse
    self.nixosModules.locale-en-us
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "uas" "usb_storage" "usbhid" "sd_mod" ];

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

  nixOSManager = {
    profiles = {
      common.enable = true;
    };

    programs = {
      nix.enable = true;
      systemd-boot.enable = true;
    };
  };






  ########################################################
  # TIME TO REPLACE THIS SHIT
  # Use latest kernel.
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    discord
    vscode.fhs
  ];
}