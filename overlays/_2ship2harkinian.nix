self: super:
{
  _2ship2harkinian = super._2ship2harkinian.overrideAttrs (old: rec {
    name = "2ship2harkinian";
    version = "git";
    src = fetchFromGitHub {
      owner = "HarbourMasters";
      repo = "2ship2harkinian";
      rev = "e714630599ba0f03b3375ed3fae50d92629d7a28";
      hash = "sha256-lsq2CCDOYZKYntu3B0s4PidpZ3EjyIPSSpHpmq4XN9U=";
      fetchSubmodules = true;
    }
  })
}