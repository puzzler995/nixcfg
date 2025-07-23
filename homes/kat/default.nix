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

  config = lib.mkMerge [
    ##### COMMON
    {
      home.username = "kat";

      programs.home-manager.enable = true;

      homeManager = {
        profiles = {
          shell.enable = true;
        };
        programs = {
          firefox.enable = true;
          ghostty.enable = true;
          git.enable = true;
          vesktop.enable = true;
        };
      };

      home.stateVersion = "25.05";
    }
    ##### MAC
    (lib.mkIf pkgs.stdenv.isDarwin {
      home.homeDirectory = "/Users/kat";
    })
    ##### LINUX
    (lib.mkIf pkgs.stdenv.isLinux {
      home.homeDirectory = "/home/kat";

      home.packages = with pkgs; [
        bitwarden-desktop
        bolt-launcher
        #dolphin-emu
        itch
        nexusmods-app-unfree
        openrct2
        owmods-gui
        #retroarch-full
        shipwright
        #sm64ex
      #_2ship2harkinian
        tenacity
      ];

      homeManager = {
        profiles = {
          archipelago.enable = true;
        };
        programs = {
          vscode.enable = true;
          jetbrains = {
            enable = false;
            intellij = true;
            rider = true;
          };
        };
      };
    })
  ];
}
