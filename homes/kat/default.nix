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
      archipelago
      bolt-launcher
      #dolphin-emu
      nexusmods-app-unfree
      openrct2
      owmods-gui
      poptracker
      #retroarch-full
      shipwright
      tenacity
    ];

    programs.home-manager.enable = true;

    homeManager = {
      programs = {
        firefox.enable = true;
        ghostty.enable = true;
        git.enable = true;
        obs.enable = true;
        vscode.enable = true;
      };
    };

    home.stateVersion = "25.05";
  };
}
