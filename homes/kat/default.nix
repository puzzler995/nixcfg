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
      bolt-launcher
      #dolphin-emu
      itch
      nexusmods-app-unfree
      openrct2
      owmods-gui
      #retroarch-full
      shipwright
      #_2ship2harkinian
      tenacity
    ];

    programs.home-manager.enable = true;

    homeManager = {
      profiles = {
        archipelago.enable = true;
        shell.enable = true;
      };
      programs = {
        firefox.enable = true;
        ghostty.enable = true;
        git.enable = true;
        jetbrains = {
          enable = true;
          intellij = true;
          rider = true;
        };
        obs.enable = true;
        vesktop.enable = true;
        vscode.enable = true;
      };
    };

    home.stateVersion = "25.05";
  };
}
