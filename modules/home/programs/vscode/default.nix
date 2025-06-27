{config, lib, pkgs, ...}: {
  options.homeManager.programs.vscode.enable = lib.mkEnableOption "vscode";
  config = lib.mkIf config.homeManager.programs.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;

      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;

        extensions = (with pkgs.vscode-extensions; [
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
        ]);

        userSettings = {
          "files.autoSave" = "onFocusChange";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "git.autoStash" = true;
          "git.autofetch" = true;
          "git.confirmSync" = false;
          "github.gitProtocol" = "ssh";
        };
      };
    };
  };
}