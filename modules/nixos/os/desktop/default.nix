{pkgs, lib, ...}: {
  options.nixOSManager.desktop.enable = lib.mkOption {
    default = false;
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
            selected_themes = [ "loader_alt" ];
          })
        ];
      };
      consoleLogLevel = 3;
      initrd.verbose = false;
      loader.timeout = 0;
    };

    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true #TODO: MOVE
        desktopManager.gnome.enable = true; #TODO: MOVE
      };

      printing.enable = true;

      pulseaudio.enable = true;
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