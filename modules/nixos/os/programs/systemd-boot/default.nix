{config, lib, ...}: {
  options.nixOSManager.programs.systemd-boot.enable = lib.mkEnableOption "Enable systemd-boot bootloader";

  config = lib.mkIf config.nixOSManager.programs.systemd-boot.enable {
    boot = {
      initrd.systemd.enable = lib.mkDefault true;

      loader = {
        efi.canTouchEfiVariables = true;

        systemd-boot = {
          enable = lib.mkDefault true;
          configurationLimit = lib.mkDefault 10;
        };
      };
    };
  };
}