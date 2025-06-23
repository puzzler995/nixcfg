{
  config,
  lib,
  ...
}: {
  options.diskManager = {
    installDrive = lib.mkOption {
      description = "Disk to install NixOS to.";
      default = "/dev/nvme0n1";
      type = lib.types.str;
    };
    swapSize = lib.mkOption {
      description = "Size of the Swap Disk e.g. 16G";
      default = "24G";
      type = lib.types.str;
    };
  };

  config = {
    assertions = [
      {
        assertion = config.diskManager.installDrive != "";
        message = "config.diskManager.installDrive cannot be empty.";
      }
      {
        assertion = config.diskManager.swapSize != "";
        message = "config.diskManager.swapSize cannot be empty.";
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
                end = "-" + config.diskManager.swapSize; # Swap fills up the rest, so we just shrink by swap
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];

                  subvolumes = {
                    "/rootfs" = {
                      mountOptions = ["compress=zstd" "noatime"];
                      mountpoint = "/";
                    };

                    "/home" = {
                      mountOptions = ["compress=zstd" "noatime"];
                      mountpoint = "/home";
                    };

                    "/home/.snapshots" = {
                      mountOptions = ["compress=zstd" "noatime"];
                      mountpoint = "/home/.snapshots";
                    };

                    "/nix" = {
                      mountOptions = ["compress=zstd" "noatime"];
                      mountpoint = "/nix";
                    };
                  };

                  mountpoint = "/partition-root";
                };
              };

              swap = {
                size = "100%";
                content = {
                  type = "swap";
                  discardPolicy = "both";
                  resumeDevice = false;
                };
              };
            };
          };
        };
      };
    };
  };
}
