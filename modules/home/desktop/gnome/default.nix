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
          clock-format = "12h";
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = false;
          edge-tiling = false;

          experimental-features = [
            "scale-monitor-framebuffer"
            "variable-refresh-rate"
            "xwayland-native-scaling"
          ];

          workspaces-only-on-primary = true;
        };

        "org/gnome/shell" = {
          welcome-dialog-last-shown-version = "99999999999999999999";
        };

        "org/gnome/system/location".enabled = true;
      };
    };

    programs = {
      firefox.nativeMessagingHosts = [pkgs.gnome-browser-connector];

      gnome-shell = {
        enable = true;

        extensions = [
          (lib.mkIf config.homeManager.desktop.gnome.dock {package = pkgs.gnomeExtensions.dash-to-dock;})
          {package = pkgs.gnomeExtensions.appindicator;}
          {package = pkgs.gnomeExtensions.arcmenu;}
          {package = pkgs.gnomeExtensions.caffeine;}
          {package = pkgs.gnomeExtensions.tiling-shell;}
        ];
      };
    };
  };
}
