{
  config,
  lib,
  pkgs,
  ...
}: {
  options.homeManager.programs.git.enable = lib.mkEnableOption "git version control";
  config = lib.mkIf config.homeManager.programs.git.enable {
    programs.git = {
      enable = true;
      delta.enable = true;
      lfs.enable = true;
      package = pkgs.gitFull;
      userName = "Katherine Marsee";
      userEmail = "ksmarsee@gmail.com";

      extraConfig = {
        color.ui = true;
        github.user = "puzzler995";
        push.autoSetupRemote = true;
      };
    };
  };
}
