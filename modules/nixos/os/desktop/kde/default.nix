{
  lib,
  config,
  pkgs,
  ...
}: {
  options.nixOSManager.desktop.kde.enable = lib.mkEnableOption "enable KDE";

  config = lib.mkIf config.nixOSManager.desktop.kde.enable {
    environment.systemPackages = with pkgs; [

    ];

    # home-manager.sharedModules = [
    #   {
    #     config.homeManager.desktop.kde.enable = true;
    #   }
    # ];
    services.desktopManager.plasma6.enable = true;
    nixOSManager.desktop.enable = true;
  };
}
