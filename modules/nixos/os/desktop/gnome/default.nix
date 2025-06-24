{lib, config, ...}: {
  options.nixOSManager.desktop.gnome.enable = lib.mkEnableOption "enable GNOME";

  config = lib.mkIf config.nixOSManager.desktop.gnome.enable {
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true; #TODO: MOVE
    nixOSManager.desktop.enable = true;
  };
}