{...}: self: super: {
  archipelago = self.inputs.pinnedArchipelagoVersion.legacyPackages.${prev.system}.archipelago;
}
