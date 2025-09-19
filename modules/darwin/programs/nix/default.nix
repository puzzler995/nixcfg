{
  config,
  lib,
  ...
}: {
  options.darwinManager.programs.nix.enable = lib.mkEnableOption "My Main Nix Config";

  config = lib.mkIf config.darwinManager.programs.nix.enable {
    nix = {
      gc = {
        automatic = true;
        options = "--delete-older-than 10d";
        interval = [{Hour = 12;}];
      };

      package = pkgs.lixPackageSets.stable.lix;

      settings = {
        trusted-users = ["@admin"];
        experimental-features = ["nix-command" "flakes"];
      };

      optimise = {
        automatic = true;
        interval = [{Hour = 9;}];
      };
    };
  };
}
