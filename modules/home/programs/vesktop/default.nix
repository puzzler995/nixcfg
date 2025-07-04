{
  config,
  lib,
  pkgs,
  ...
}: {
  options.homeManager.programs.vesktop.enable = lib.mkEnableOption "vesktop";

  config = lib.mkIf config.homeManager.programs.vesktop.enable {
    programs.vesktop = {
      enable = true;

      settings = {
        discordBranch = "stable";
        minimizeToTray = false;
        arRPC = true;
        customTitleBar = lib.mkIf pkgs.stdenv.isLinux true;
        hardwareAcceleration = true;
      };

      vencord.settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        useQuickCss = true;
        plugins = {
          AlwaysTrust = {
            enabled = true;
            domain = true;
            file = true;
          };

          BetterFolders = {
            enabled = true;
            sidebar = true;
            showFolderIcon = "1";
            keepIcons = false;
            closeAllHomeButton = false;
            closeAllFolders = false;
            forceOpen = false;
            sidebarAnim = true;
            closeOthers = false;
          };

          BetterSessions = {
            enabled = true;
            backgroundCheck = false;
          };

          BetterSettings = {
            enabled = true;
            disableFade = true;
            eagerLoad = true;
          };

          BiggerStreamPreview.enabled = true;

          CallTimer = {
            enabled = true;
            format = "stopwatch";
          };

          ClearURLs.enabled = true;
          CrashHandler.enabled = true;
          FriendsSince.enabled = true;
          GreetStickerPicker.enabled = true;

          ImplicitRelationships = {
            enabled = true;
            sortByAffinity = true;
          };

          LoadingQuotes = {
            enabled = true;
            replaceEvents = true;
            enablePluginPresetQuotes = true;
            enableDiscordPresetQuotes = false;
          };

          MemberCount = {
            enabled = true;
            memberList = true;
            toolTip = true;
          };

          MentionAvatars = {
            enabled = true;
            showAtSymbol = true;
          };

          NoF1.enabled = true;

          PlatformIndicators = {
            enabled = true;
            colorMobileIndicator = true;
            list = true;
            badges = true;
            messages = true;
          };

          SendTimestamps = {
            enabled = true;
            replaceMessageContents = true;
          };

          WebKeybinds.enabled = true;
          WebScreenShareFixes.enabled = true;
          WhoReacted.enabled = true;
        };
      };
    };
  };
}
