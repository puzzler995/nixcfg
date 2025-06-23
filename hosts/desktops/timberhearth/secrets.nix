{self, ...}: {
  sops.secrets = {
    "tailscale/authkey" = {
      owner = "kat";
      path = "/home/kat/testk";
    };
  };
}