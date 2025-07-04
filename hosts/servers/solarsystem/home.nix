{self, ...}: {
  home-manager.users.kat = {pkgs, ...}: {
    imports = [
      self.homeManagerModules.default
    ];

    home = {
      homeDirectory = "/home/kat";

      stateVersion = "25.05";
      username = "kat";
    };
    programs.home-manager.enable = true;
    homeManager = {
      programs = {
        git.enable = true;
      };

      profiles = {
        shell.enable = true;
      };
    };
  };
}