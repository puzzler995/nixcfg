{
  config,
  lib,
  pkgs,
  ...
}: {
  options.homeManager.programs.vscode.enable = lib.mkEnableOption "vscode";
  config = lib.mkIf config.homeManager.programs.vscode.enable {
    programs.vscode = {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isLinux pkgs.vscode.fhs;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = with pkgs.vscode-extensions; [
          continue.continue
          eamodio.gitlens
          esbenp.prettier-vscode
          foxundermoon.shell-format
          github.vscode-github-actions
          github.vscode-pull-request-github
          jnoortheen.nix-ide
          mads-hartmann.bash-ide-vscode
          mkhl.direnv
          ms-vscode-remote.remote-ssh
          redhat.vscode-yaml
          oderwat.indent-rainbow
          # ]) ++ (with pkgs.vscode-marketplace; [
        ];

        userSettings = {
          "files.autoSave" = "onFocusChange";
          "editor.formatOnPaste" = false;
          "editor.formatOnSave" = false;
          "editor.formatOnType" = false;
          "git.autoStash" = true;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "github.gitProtocol" = "ssh";
          "yaml.schemas" = {
            "/home/kat/.vscode/extensions/continue.continue-1.0.15-linux-x64/config-yaml-schema.json" = [
              ".continue/**/*.yaml"
            ];
          };
        };
      };
    };
  };
}
