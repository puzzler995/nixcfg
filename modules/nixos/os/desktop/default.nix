{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./gnome
    ./cosmic
  ];

  options.nixOSManager.desktop.enable = lib.mkOption {
    default = config.nixOSManager.desktop.gnome.enable;
    description = "Default Agnostic Desktop Config";
    type = lib.types.bool;
  };

  config = lib.mkIf config.nixOSManager.desktop.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "loader_alt";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = ["loader_alt"];
          })
        ];
      };
      consoleLogLevel = 3;
      initrd.verbose = false;
      loader.timeout = 0;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    services = {
      xserver = {
        enable = true;
      };

      printing.enable = true;

      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
      };
    };
  };
}
