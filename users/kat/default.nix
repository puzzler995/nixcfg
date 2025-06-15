{ config, lib, pkgs, self, ...}: 
{
  users.users.kat = {
    description = "Katherine Marsee";
    extraGroups
  }
}