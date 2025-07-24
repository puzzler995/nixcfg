_: self: super: {
  inherit (self.inputs.pinnedArchipelagoVersion.legacyPackages.${self.system}) archipelago;
}
