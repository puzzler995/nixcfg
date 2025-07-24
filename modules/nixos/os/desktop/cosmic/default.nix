{
  lib,
  config,
  ...
}: {
  options.nixOSManager.desktop.cosmic.enable = lib.mkEnableOption "enable cosmic";

  config = lib.mkIf config.nixOSManager.desktop.cosmic.enable {
    services.desktopManager.cosmic.enable = true;
    nixOSManager.desktop.enable = true;
  };
}
