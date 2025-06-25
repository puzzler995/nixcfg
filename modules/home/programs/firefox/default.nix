{config, lib, pkgs, ...}: let engines = import ./engines.nix; in {
  options.homeManager.programs.firefox.enable = lib.mkEnableOption "firefox web browser";

  config = lib.mkIf config.homeManager.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isDarwin null;

      profiles = {
        default = {
          extensions = {
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              augmented-steam
              betterttv
              bitwarden
              clearurls
              consent-o-matic
              enhanced-github
              enhancer-for-nebula
              enhancer-for-youtube
              indie-wiki-buddy
              languagetool
              pronoundb
              reddit-enhancement-suite
              sponsorblock
              ublock-origin
            ];
          force = true;
          };
          id = 0;
          search = {
            inherit engines;
            default = "ddg";
            force = true;
          };
          settings = {
            "extensions.autoDisableScopes" = 0;
          };
        };
      };
    };
  };
}