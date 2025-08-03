_: self: super: {
  vvvvvv = super.vvvvvv.overrideAttrs (prev: rec {
    name = "vvvvvv";
    version = "AP0.5.1-2";
    src = super.fetchFromGitHub {
      owner = "N00byKing";
      repo = "VVVVVV";
      rev = "archipelago";
      hash = "sha256-v7V/1HgT+jYjzbasvoZbJRylC3HjdWeJVtdP1Bsh5bs=";
      fetchSubmodules = true;
    };
    buildInputs = [
      super.faudio
      super.physfs
      super.SDL2
      super.tinyxml-2
      super.openssl
    ];
  });
}
