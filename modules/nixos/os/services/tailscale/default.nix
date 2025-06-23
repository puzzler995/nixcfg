{self, lib, config, pkgs, ...}: {
  options.nixOSManager.services.tailscale = {
    enable = lib.mkEnableOption "Enable Tailscale VPN";

    authKeyFile = lib.mkOption {
      description = "Key file for tailscale auth";
      default = config.sops.secrets."tailscale/authkey".path or null;
      type = lib.types.nullOr lib.types.path;
    };

    operator = lib.mkOption {
      description = "Tailscale operator name";
      default = null;
      type = lib.types.nullOr lib.types.str;
    };
  };

  config = lib.mkIf config.nixOSManager.services.tailscale.enable {
    assertions = [
      {
        assertion = config.nixOSManager.services.tailscale.authKeyFile != null;
        message = "You need an auth key for tailscale";
      }
    ];

    home-manager.sharedModules = [ {
      programs.gnome-shell.extensions = [
        {package = pkgs.gnomeExtensions.tailscale-qs;}
      ];
    }
    ];

    networking.firewall = {
      allowedUDPPorts = [config.services.tailscale.port];
      trustedInterfaces = [config.services.tailscale.interfaceName];
    };

    services ={
      tailscale = {
        enable = true;
        inherit (config.nixOSManager.services.tailscale) authKeyFile;

        extraUpFlags = ["--ssh"] ++ lib.optional (config.nixOSManager.services.tailscale.operator != null) "--operator ${config.nixOSManager.services.tailscale.operator}";
        openFirewall = true;

        useRoutingFeatures = "both";
      };
    };
  };
}