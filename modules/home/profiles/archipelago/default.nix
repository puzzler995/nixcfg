{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.homeManager.profiles.archipelago.enable = lib.mkEnableOption "Archipelago and it's utilities";
  config = lib.mkIf config.homeManager.profiles.archipelago.enable {
    home.packages = with pkgs; [
      archipelago
      poptracker
      self.inputs.katpkgs.packages.${system}.autopelago
      (lib.hiPrio sm64ex)
      vvvvvv
      # self.inputs.bizhawk.packages.x86_64-linux.emuhawk-2_9_1
    ];
  };
}
