{ config, lib, pkgs, ...}:{
  options.homeManager.profiles.shell.enable = lib.mkEnableOption "basic shell setup";

  config = lib.mkIf config.homeManager.profiles.shell.enable {
    home.packages = with pkgs; [
      (lib.hiPrio uutils-coreutils-noprefix)
    ];

    programs = {
      bash = {
        enable = true;
        enableCompletion = true;
        enableVteIntegration = true;
      };

      bat.enable = true;

      bottom.enable = true;
      
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };

      fzf.enable = true;
      htop.enable = true;

      lsd = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      oh-my-posh = {
        enable = true;
        useTheme = "glowsticks";
      };

      pay-respects = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      ripgrep-all.enable = true;

      zsh = {
        enable = true;
        autocd = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        enableVteIntegration = true;

        initContent = ''
          [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

          if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
            export TERM=xterm-256color
          fi
        '';

        historySubstringSearch.enable = true;

        history = {
          expireDuplicatesFirst = true;
          extended = true;
          ignoreAllDups = true;
        };

        shellAliases = {
          ll = "ls -lah";
          cat = "bat";
          ls = "lsd";
          ".." = "cd ..";
        };
      };
    };
  };
}