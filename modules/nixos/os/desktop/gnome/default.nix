{
  lib,
  config,
  ...
}: {
  options.nixOSManager.desktop.gnome.enable = lib.mkEnableOption "enable GNOME";

  config = lib.mkIf config.nixOSManager.desktop.gnome.enable {
    home-manager.sharedModules = [
      {
        config.homeManager.desktop.gnome.enable = true;
        config.homeManager.desktop.gnome.dock = true;
      }
    ];
    services.desktopManager.gnome.enable = true;
    nixOSManager.desktop.enable = true;
  };
}
