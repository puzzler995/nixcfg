{config, self, pkgs, lib, ...}: {

  microvm = {
    hypervisor = "qemu";
    interfaces = [
      {
        type = "tap";
        id = "vm-test1";
        mac ="02:00:00:00:00:01";
      }
    ];
    shares = [
      {
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
    ];
  };

  networking = {
    hostName = "attlerock";
    useNetworkd = true;
  };

  system.stateVersion = "25.05";
  time.timeZone = "America/New_York";

  systemd.network = {
    enable = true;
    networks = {
      "20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = ["192.168.1.201/24"];
          Gateway = "192.168.1.1";
          DNS = ["192.168.1.1"];
          DHCP = "no";
        };
      };
    };
  };

  userManager = {
    kat = {
      enable = true;
      password = "$y$j9T$fXCNJ5L3S4.VfMhNbw3V31$n8k8chfUm8pKn5rbscHhbpDhvcq7JZJNxF9MMDfXUB3";
    };
  };

  nixOSManager = {

    profiles = {
      autoUpgrade.enable = true;
      common.enable = true;
    };

    programs = {
      nix.enable = true;
    };

    services = {
      #TODO tailscale.enable = true;
    };
  };
}