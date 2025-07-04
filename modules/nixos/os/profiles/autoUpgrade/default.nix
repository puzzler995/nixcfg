{config, lib, pkgs, ...}: {
  options.nixOSManager.profiles.autoUpgrade.enable = lib.mkEnableOption "Auto Upgrade the System";

  config = lib.mkIf config.nixOSManager.profiles.autoUpgrade.enable {
    system.autoUpgrade = {
      enable = true;
      allowReboot = lib.mkDefault true;
      dates = "03:00";
      flags = ["--accept-flake-config"];
      flake = config.environment.variables.FLAKE or "github:puzzler995/nixcfg";
      operation = lib.mkDefault "boot";
      persistent = true;
      randomizedDelaySec = "60min";

      rebootWindow = {
        lower = "03:00";
        upper = "06:00";
      };
    };
      # Allow nixos-upgrade to restart on failure (e.g. when laptop wakes up before network connection is set)
      systemd.services.nixos-upgrade = {
        preStart = "${pkgs.host}/bin/host google.com"; # Check network connectivity

        serviceConfig = {
          Restart = "on-failure";
          RestartSec = "120";
        };

        unitConfig = {
          StartLimitIntervalSec = 600;
          StartLimitBurst = 2;
        };
      };
    };

}