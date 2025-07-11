{self, ...}: {
  home-manager.users.kat = {
    config, lib, ...
  }: {
    imports = [
      self.homeManagerModules.kat
    ];
  };
}