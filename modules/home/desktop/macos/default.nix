{
  config,
  lib,
  ...
}: {
  options.homeManager.desktop.macos.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable macOS settings.";
  };

  config = lib.mkIf config.homeManager.desktop.macos.enable {
    targets.darwin = {
        defaults = {
            "com.apple.dock" = {
                autohide = true;
                expose-group-apps = true;
                minimize-to-application = true;
                mru-spaces = false;
                show-recents = false;
            };
        };
      #defaults = {
      #  "com.apple.desktopservices" = {
      #    DSDontWriteNetworkStores = true;
      #    DSDontWriteUSBStores = true;
      #  };

      #  "com.apple.dock" = {
      #    orientation = "left"; # left side of the screen
      #    scroll-to-open = true; # scroll over app to expose
      #    size-immutable = true;
      #    tilesize = 64;
      #    workspaces-wrap-arrows = false;

      #    # # set hot corners
      #    wvous-tl-corner = 2;
      #    wvous-tr-corner = 12;
      #    wvous-bl-corner = 11;
      #    wvous-br-corner = 14;

      #    # persistent-apps = [];
      #    # # persistent-others = ["~/Desktop" "~/Downloads"];
      #  };

      #  "com.apple.finder" = {
      #    _FXSortFoldersFirstOnDesktop = true;
      #    AppleShowAllExtensions = true;
      #    AppleShowAllFiles = true; # show hidden files
      #    CreateDesktop = false; # do not show icons on desktop
      #    FXDefaultSearchScope = "SCcf"; # search current folder by default
      #    FXEnableExtensionChangeWarning = false;
      #    FXPreferredViewStyle = "Nlsv";
      #    FXRemoveOldTrashItems = true;
      #    NewWindowTarget = "Home";
      #    QuitMenuItem = true;
      #    ShowPathbar = true;
      #    ShowStatusBar = true; # show status bar
      #  };

      #  "com.apple.Siri" = {
      #    ConfirmSiriInvokedViaEitherCmdTwice = 0;
      #    ContinuousSpellCheckingEnabled = 0;
      #    GrammarCheckingEnabled = 1;
      #    StatusMenuVisible = 0;
      #    VoiceTriggerUserEnabled = 1;
      #  };

      #  NSGlobalDomain = {
      #    NSAutomaticSpellingCorrectionEnabled = false;
      #    NSDocumentSaveNewDocumentsToCloud = false;
      #    NSNavPanelExpandedStateForSaveMode = true;
      #    NSNavPanelExpandedStateForSaveMode2 = true;
      #    NSQuitAlwaysKeepsWindows = false;
      #    NSWindowShouldDragOnGesture = true;
      #    PMPrintingExpandedStateForPrint = true;
      #    PMPrintingExpandedStateForPrint2 = true;
      #  };
      #};

      search = "DuckDuckGo";
    };
  };
}