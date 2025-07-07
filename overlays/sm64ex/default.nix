{...}: self: super: {
  _2ship2harkinian = super._2ship2harkinian.overrideAttrs (old: rec {
    name = "sm64ex";
    version = "git";
    src = super.fetchFromGitHub {
      owner = "N00byKing";
      repo = "sm64ex";
      rev = "0e88a60f94535ef9653e9c66c53d3178d131e5e0";
      hash = "sha256-YGURLXlzbnJ3NYUDOZfHK3D6Rhqnh98Brp03pP0uzek=";
      fetchSubmodules = true;
    };
  });
}
