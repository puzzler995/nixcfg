{
  config,
  lib,
  ...
}: {
  options.nixOSManager.services.sddm = {
    enable = lib.mkEnableOption "sddm display manager";

    autoLogin = lib.mkOption {
      description = "User to autologin.";
      default = null;
      type = lib.types.nullOr lib.types.str;
    };
  };

  config = lib.mkIf config.nixOSManager.services.sddm.enable {
    security.pam.services.sddm = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
      kwallet.enable = true;
    };

    services = {
      displayManager = {
        autoLogin = lib.mkIf (config.nixOSManager.services.sddm.autoLogin != null) {
          enable = true;
          user = config.nixOSManager.services.sddm.autoLogin;
        };

        sddm = {
          enable = true;

          wayland = {
            enable = true;
            compositor = "kwin";
          };
        };
      };
    };
  };
}
