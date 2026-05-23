{
  lib,
  config,
  pkgs,
  userName,
  homeDirectory,
  userDescription,
  system,
  hostName,
  timeZone,
  ...
}:
{
  users = {
    mutableUsers = true;
    allowNoPasswordLogin = true;
    users.${userName} = {
      isNormalUser = true;
      description = userDescription;
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
        "video"
        "docker"
      ];
      packages = with pkgs; [
        firefox
      ];
    };
  };
}
