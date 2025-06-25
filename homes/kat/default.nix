{
  config,
  pkgs,
  lib,
  self,
  ...
}: {
  imports = [
    self.homeManagerModules.default
  ];

  config = {
    home.username = "kat";
    home.homeDirectory = "/home/kat";

    home.packages = with pkgs; [
      neofetch
      jq
    ];

    programs.home-manager.enable = true;

    homeManager = {
      programs = {
        firefox.enable = true;
        ghostty.enable = true;
        git.enable = true;
      };
    };

    home.stateVersion = "25.05";
  };
}
