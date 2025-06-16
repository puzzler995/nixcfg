{ config, pkgs, ...}: 
{
  users.users.kat = {
    description = "Katherine Marsee";
    extraGroups = config.userManager.defaultGroups;
    hashedPassword = config.userManager.kat.password;
    isNormalUser = true;

    shell = pkgs.zsh;
    uid = 1000;
  };
}