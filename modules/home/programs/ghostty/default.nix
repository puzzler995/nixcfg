{config, lib, pkgs, ...}: {
  options.homeManager.programs.ghostty.enable = lib.mkEnableOption "ghostty terminal emulator";
  config = lib.mkIf config.homeManager.programs.ghostty.enable {
    programs.ghostty = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isDarwin null;
      settings = {
        app-notifications = "no-clipboard-copy";
        copy-on-select = "clipboard";
        gtk-single-instance = lib.mkIf pkgs.stdenv.isLinux true;
        quit-after-last-window-closed = lib.mkIf pkgs.stdenv.isLinux false;
      };
    };
  };
}