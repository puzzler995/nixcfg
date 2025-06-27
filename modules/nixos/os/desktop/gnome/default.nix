{lib, config, ...}: {
  options.nixOSManager.desktop.gnome.enable = lib.mkEnableOption "enable GNOME";

  config = lib.mkIf config.nixOSManager.desktop.gnome.enable {
    home-manager.sharedModules = [
      {
        config.homeManager.desktop.gnome.enable = true;
        config.homeManager.desktop.gnome.dock = true;
      }
    ];
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.displayManager.gdm.enable = true; #TODO: MOVE
    nixOSManager.desktop.enable = true;
  };
}