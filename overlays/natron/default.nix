_: self: super: {
  natron = super.natron.overrideAttrs (old: rec {
    nativeBuildInputs = [
      cmake
      extra-cmake-modules
      pkg-config
      wrapQtAppsHook
    ];
    
  });
}