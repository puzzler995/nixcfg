{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  options.nixOSManager.profiles.common.enable = lib.mkEnableOption "Common System Config Profile.";

  config = lib.mkIf config.nixOSManager.profiles.common.enable {
    environment = {
      etc."nixos".source = self;

      systemPackages = with pkgs; [
        (lib.hiPrio uutils-coreutils-noprefix)
        git
        vim
        lm_sensors
        wget
        curl
        ssh-to-age
        sops
      ];

      variables = {
        # FLAKE = lib.mkDefault "git+ssh://git@github.com/puzzler995/nixcfg.git";
        # NH_FLAKE = lib.mkDefault "git+ssh://git@github.com/puzzler995/nixcfg.git";
        FLAKE = lib.mkDefault "git+file:///home/kat/dev/nixcfg";
        NH_FLAKE = lib.mkDefault "git+file:///home/kat/dev/nixcfg";
      };
    };

    programs = {
      dconf.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
        silent = true;
      };

      nh.enable = true;
    };

    networking.networkmanager.enable = true;

    security = {
      polkit.enable = true;
      rtkit.enable = true;

      sudo-rs = {
        enable = true;
        wheelNeedsPassword = false;
      };
    };

    services = {
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;

        publish = {
          enable = true;
          addresses = true;
          userServices = true;
          workstation = true;
        };
      };

      openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = true;
          AllowUsers = null;
          UseDns = true;
          PermitRootLogin = "prohibit-password";
        };
      };
    };
    system = {
      #configurationRevision = self.rev or self.dirtyRev or null;
      configurationRevision = null;
      rebuild.enableNg = true;
    };
  };
}
