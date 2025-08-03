_: self: super: {
  vvvvvv = super.vvvvvv.overrideAttrs (prev: rec {
    name = "vvvvvv";
    version = "AP0.5.1-2";
    src = super.fetchFromGitHub {
      owner = "N00byKing";
      repo = "VVVVVV";
      rev = "AP0.5.1-2";
      hash = "sha256-8gEsQca4lwRX2dDNFD+QlwZIVwLWIqaR2n3N+jd7yLE=";
      fetchSubmodules = true;
    };
  });
}
