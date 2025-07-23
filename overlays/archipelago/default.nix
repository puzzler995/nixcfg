{...}: self: super: {
  archipelago = self.inputs.pinnedArchipelagoVersion.legacyPackages.${self.system}.archipelago;
}
