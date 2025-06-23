{self, ...}: {
  sops.secrets = {
    "tailscale/authkey" = {};
  };
}
