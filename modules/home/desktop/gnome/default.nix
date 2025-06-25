{
  config,
  lib,
  pkgs,
  ...
}: {
  options.homeManager.desktop.gnome = {
    enable = lib.mkEnableOption "GNOME desktop environment";
    dock = lib.mkEnableOption "GNOME dash-to-dock extension";
  };

  config = lib.mkIf config.homeManager.desktop.gnome.enable {
    dconf = {
      enable = true;

      settings = {
        "org/gnome/desktop/datetime".automatic-timezone = true;
        "org/gnome/desktop/interface" = {
          clock-format = "12h"
          
        };

      };
    };
  };
}