{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  commonPlugins = [
    "ini"
    "grep-console"
    "file-watchers"
    "docker"
    "toml"
    "nixidea"
    "-env-files"
    "rainbow-brackets"
    "extra-icons"
    "indent-rainbow"
    "protocol-buffers"
    "mario-progress-bar"
    "codeglance-pro"
    "better-direnv"
  ];
  intellijPlugins = ["maven-helper"] ++ commonPlugins;
in {
  options.homeManager.programs.jetbrains = {
    enable = lib.mkEnableOption "Jetbrains Suite";
    intellij = lib.mkEnableOption "IntelliJ";
    pycharm = lib.mkEnableOption "PyCharm";
    rider = lib.mkEnableOption "Rider";
    rustRover = lib.mkEnableOption "Rust Rover";
    webstorm = lib.mkEnableOption "Webstorm";
  };
  config = lib.mkIf config.homeManager.programs.jetbrains.enable {
    home.packages = [
      (lib.mkIf config.homeManager.programs.jetbrains.intellij (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate intellijPlugins))
      (lib.mkIf config.homeManager.programs.jetbrains.pycharm (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-professional commonPlugins))
      (lib.mkIf config.homeManager.programs.jetbrains.rider (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.rider commonPlugins))
      (lib.mkIf config.homeManager.programs.jetbrains.rustRover (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.rust-rover commonPlugins))
      (lib.mkIf config.homeManager.programs.jetbrains.webstorm (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.webstorm commonPlugins))
    ];
  };
}
