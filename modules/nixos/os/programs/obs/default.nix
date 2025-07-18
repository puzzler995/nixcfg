{
  config,
  lib,
  pkgs,
  ...
}: {
  options.nixOSManager.programs.obs = {
    enable = lib.mkEnableOption "obs studio";
    nvidia.enable = lib.mkEnableOption "NVENC Encoding";
  };

  config = lib.mkIf config.nixOSManager.programs.obs.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      package = lib.mkIf config.nixOSManager.programs.obs.nvidia.enable (pkgs.obs-studio.override {
        cudaSupport = true;
      });
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        obs-backgroundremoval
        obs-mute-filter
        droidcam-obs
        # pkgs.obs-studio-plugins.distroav
      ];
    };
  };
}
