{self, ...}: {
  home-manager.users = {
    inherit (self.homeManagerModules) kat;
  };
}
