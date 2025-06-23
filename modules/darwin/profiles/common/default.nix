{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.darwinManager.profiles.common.enable = lib.mkEnableOption "common system profile";

  config = lib.mkIf config.darwinManager.profiles.common.enable {
    environment = {
      systemPackages = with pkgs; [
        nh
      ];

      variables = {
        FLAKE = lib.mkDefault "git+https://github.com/puzzler995/nixcfg.git";
        NH_FLAKE = lib.mkDefault "git+https://github.com/puzzler995/nixcfg.git";
      };
    };

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };
    };

    security.pam.services.sudo_local.touchIdAuth = true;
    services.openssh.enable = true;

    system = {
      defaults.alf = {
        globalstate = 1;
        loggingenabled = 1;
      };
    };
  };
}
