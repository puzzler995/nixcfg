{
  config,
  lib,
  ...
}: {
  options.nixOSManager.services.gdm = {
    enable = lib.mkEnableOption "gdm display manager";

    autoLogin = lib.mkOption {
      description = "User to autologin.";
      default = null;
      type = lib.types.nullOr lib.types.str;
    };
  };

  config = lib.mkIf config.nixOSManager.services.gdm.enable {
    security.pam.services.gdm = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
      kwallet.enable = true;
    };

    services = {
      displayManager = {
        autoLogin = lib.mkIf (config.nixOSManager.services.gdm.autoLogin != null) {
          enable = true;
          user = config.nixOSManager.services.gdm.autoLogin;
        };

        gdm.enable = true;
      };
    };
  };
}
