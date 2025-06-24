{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nixOSManager.programs.steam = {
    enable = lib.mkEnableOption "Steam";
    session.enable = lib.mkEnableOption "Steam + Gamescope";
  };

  config = lib.mkIf config.nixOSManager.programs.steam.enable {
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = lib.makeSearchPathOutput "steamcompattool" "" config.programs.steam.extraCompatPackages;
    };

    hardware.steam-hardware.enable = true;

    programs = {
      gamescope.enable = true;

      steam = {
        enable = true;
        dedicatedServer.openFirewall = true;
        extest.enable = true;
        extraCompatPackages = with pkgs; [proton-ge-bin];
        gamescopeSession.enable = config.nixOSManager.programs.steam.session.enable;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
      };
    };
  };
}