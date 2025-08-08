{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.nixOSManager.programs.obs = {
    enable = lib.mkEnableOption "obs studio";
    nvidia.enable = lib.mkEnableOption "NVENC Encoding";
  };

  config = lib.mkIf config.nixOSManager.programs.obs.enable {
    environment.systemPackages = with pkgs; [
      self.inputs.katpkgs.packages.${system}.nightbot-now-playing
      self.inputs.katpkgs.packages.${system}.touch-portal
      self.inputs.katpkgs.packages.${system}.firebot
    ];
    networking.firewall = {
      allowedUDPPorts = [12135];
      allowedTCPPorts = [12135];
    };
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
        obs-websocket
        distroav
      ];
    };
  };
}
