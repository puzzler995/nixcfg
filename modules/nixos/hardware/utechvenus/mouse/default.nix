{pkgs, ...}: {
  environment.systemPackages = with pkgs; [mouse_m908];
  services.udev.packages = with pkgs; [mouse_m908];
}
