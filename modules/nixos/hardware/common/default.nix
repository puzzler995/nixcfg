{
  lib,
  ...
}: {
  config = {
    console.useXkbConfig = true;

    hardware = {
      enableAllFirmware = true;
    };

    services = {
      fstrim.enable = true;

      logind = {
        powerKey = "suspend";
        powerKeyLongPress = "poweroff";
      };

      xserver.xkb.layout = "us";
    };

    zramSwap.enable = lib.mkDefault true;
  };
}