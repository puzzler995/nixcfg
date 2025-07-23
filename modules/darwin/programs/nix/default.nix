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

      #linux-builder = {
      #  enable = true;
      #  ephemeral = true;
      #  maxJobs = 4;
      #  config = {
      #    virtualisation = {
      #      darwin-builder = {
      #        diskSize = 40 * 1024;
      #        memorySize = 8 * 1024;
      #      };
      #      cores = 6;
      #    };
      #  };
      #};

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
