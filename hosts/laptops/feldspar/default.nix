{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./home.nix
  ];
  environment.systemPackages = with pkgs; [
    (lib.hiPrio uutils-coreutils-noprefix)
    git
    vim
    bottom
    wget
    curl
    bat
    lsd

    mas
    bash
    htop
  ];

  homebrew = {
    enable = true;
    global.autoUpdate = false;

    casks = let
      greedy = name: {
        inherit name;
        greedy = true;
      };
    in [
      (greedy "bitwarden")
      (greedy "ghostty")
      (greedy "fork")
      (greedy "itch")
      (greedy "obsidian")
      (greedy "vesktop")
      (greedy "visual-studio-code")
    ];

    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };

    taps = builtins.attrNames config.nix-homebrew.taps;
  };

  networking = {
    computerName = "feldspar";
    hostName = "feldspar";
    localHostName = "feldspar";
  };

  nix-homebrew = {
    enable = true;
    # mutableTaps = false;

    taps = {
      "homebrew/homebrew-core" = self.inputs.homebrew-core;
      "homebrew/homebrew-cask" = self.inputs.homebrew-cask;
    };

    autoMigrate = true;

    user = "kat";
  };

  nixpkgs.hostPlatform = "x86_64-darwin";

  system = {
    primaryUser = "kat";
    stateVersion = 6;
  };

  users.users.kat = {
    description = "Katherine Marsee";
    home = "/Users/kat";

    shell = pkgs.zsh;
  };

  darwinManager = {
    profiles.common.enable = true;
    programs.nix.enable = true;
  };
}
