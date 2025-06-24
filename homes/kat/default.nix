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

    programs.git = {
      enable = true;
      userName = "Katherine Marsee";
      userEmail = "ksmarsee@gmail.com";
    };

    home.stateVersion = "25.05";
  };
}
