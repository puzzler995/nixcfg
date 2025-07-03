{config, lib, pkgs, bizhawk, ...}: {
  options.homeManager.profiles.archipelago.enable = lib.mkEnableOption "Archipelago and it's utilities";
  config = lib.mkIf config.homeManager.profiles.archipelago.enable {
    home.packages = with pkgs; [
      archipelago
      poptracker
      bizhawk.emuhawk-2_9_1
    ];

  };
}