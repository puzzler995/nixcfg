{
  config,
  lib,
  ...
}: {
  options.nixOSManager.programs.nix.enable = lib.mkEnableOption "My Main Nix Config";

  config = lib.mkIf config.nixOSManager.programs.nix.enable {
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 10d";
        persistent = true;
        randomizedDelaySec = "60min";
      };

      extraOptions = ''
        min-free = ${toString (1 * 1024 * 1024 * 1024)}   # 1 GiB
        max-free = ${toString (5 * 1024 * 1024 * 1024)}   # 5 GiB
      '';

      optimise = {
        automatic = true;
        persistent = true;
        randomizedDelaySec = "60min";
      };

      settings = {
        experimental-features = ["nix-command" "flakes"];
      };
    };

    programs = {
      nix-ld.enable = true;
      nix-index = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
      }
    };
  };
}
