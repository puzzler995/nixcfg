{
  config,
  pkgs,
  ...
}: {
  home.username = "kat";
  home.homeDirectory = "/home/kat";

  home.packages = with pkgs; [
    neofetch
    jq
    nix-output-monitor
  ];

  programs.git = {
    enable = true;
    userName = "Katherine Marsee";
    userEmail = "ksmarsee@gmail.com";
  };

  home.stateVersion = "25.05";
}
