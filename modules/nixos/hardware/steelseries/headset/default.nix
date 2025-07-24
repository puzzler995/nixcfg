{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    headsetcontrol
  ];

  services.udev.packages = with pkgs; [
    headsetcontrol
  ];
}
