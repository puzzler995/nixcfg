{config, lib, pkgs, ...}: {
  options.homeManager.programs.obs.enable = lib.mkEnableOption "obs studio";

  config = lib.mkIf config.homeManager.programs.obs.enable {
    programs.obs = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.obs-pipewire-audio-capture
        # pkgs.obs-studio-plugins.distroav
      ];
    };
  };
}