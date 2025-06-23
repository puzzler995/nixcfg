{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./kat
    ./options.nix
  ];

  config = lib .mkIf (config.userManager.root.enable or config.userManager.kat.enable) {
    programs.zsh.enable = true;

    users = {
      defaultUserShell = pkgs.zsh;
      mutableUsers = false;
    };
  };
}
