{
  config,
  self,
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

  
}