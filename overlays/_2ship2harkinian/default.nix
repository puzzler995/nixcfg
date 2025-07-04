{...}: self: super: {
  _2ship2harkinian = super._2ship2harkinian.overrideAttrs (old: rec {
    name = "2ship2harkinian";
    version = "git";
    src = super.fetchFromGitHub {
      owner = "HarbourMasters";
      repo = "2ship2harkinian";
      rev = "e714630599ba0f03b3375ed3fae50d92629d7a28";
      hash = "sha256-YGURLXlzbnJ3NYUDOZfHK3D6Rhqnh98Brp03pP0uzek=";
      fetchSubmodules = true;
    };
  });
}
