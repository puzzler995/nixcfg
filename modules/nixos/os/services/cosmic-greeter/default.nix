{
  config,
  lib,
  ...
}: {
  options.nixOSManager.services.cosmic-greeter = {
    enable = lib.mkEnableOption "cosmic-greeter display manager";

    autoLogin = lib.mkOption {
      description = "User to autologin.";
      default = null;
      type = lib.types.nullOr lib.types.str;
    };
  };

  config = lib.mkIf config.nixOSManager.services.cosmic-greeter.enable {
    security.pam.services.cosmic-greeter = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
      kwallet.enable = true;
    };

    services = {
      displayManager = {
        autoLogin = lib.mkIf (config.nixOSManager.services.cosmic-greeter.autoLogin != null) {
          enable = true;
          user = config.nixOSManager.services.cosmic-greeter.autoLogin;
        };

        cosmic-greeter.enable = true;
      };
    };
  };
}
