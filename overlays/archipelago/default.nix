{...}: self: super: {
  archipelago = super.archipelago.overrideAttrs (prev: rec {
    version = "0.6.1";
  });
}
