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
        (calibre.override {
          unrarSupport = true;
        })
        cider-2
        dolphin-emu
        itch
        nexusmods-app-unfree
        openrct2
        owmods-gui
        (retroarch.withCores (cores: with cores; [
          snes9x
          sameboy
          citra
          desmume
          gambatte
          mgba
          ppsspp
        ]))
        shipwright
        signal-desktop
        spotify
        #_2ship2harkinian
        tenacity
        xivlauncher
        fflogs
      ];

      homeManager = {
        profiles = {
          archipelago.enable = true;
        };
        programs = {
          vesktop.enable = true;
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
