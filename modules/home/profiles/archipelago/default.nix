{
  config,
  lib,
  pkgs,
  self,
  ...
}: let 
  system = "x86_64-linux";
  bizhawk = import self.inputs.bizhawk-src {
    inherit pkgs system;
    gnome-themes-extra = pkgs.gnome-themes-extra;
    forNixOS = true;
  };
in {
  options.homeManager.profiles.archipelago.enable = lib.mkEnableOption "Archipelago and it's utilities";
  config = lib.mkIf config.homeManager.profiles.archipelago.enable {
    home.packages = with pkgs; [
      archipelago
      poptracker
      self.inputs.katpkgs.packages.${system}.autopelago
      (lib.hiPrio sm64ex)
      vvvvvv
      bizhawk.emuhawk-2_9_1
    ];
  };
}
