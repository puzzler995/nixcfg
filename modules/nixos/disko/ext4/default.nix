{
  config,
  lib,
  ...
}: {
  options.diskManager.installDrive = lib.mkOption {
    description = "Disk to install NixOS to.";
    default = "/dev/sda";
    type = lib.types.str;
  };

  config = {
    assertions = [
      {
        assertion = config.diskManager.installDrive != "";
        message = "config.diskManager.installDrive cannot be empty.";
      }
    ];

    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = config.diskManager.installDrive;

          content = {
            type = "gpt";

            partitions = {
              ESP = {
                content = {
                  format = "vfat";
                  mountOptions = ["umask=0077"];
                  mountpoint = "/boot";
                  type = "filesystem";
                };

                end = "1024M";
                name = "ESP";
                priority = 1;
                start = "1M";
                type = "EF00";
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
