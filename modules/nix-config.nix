{
  config,
  lib,
  pkgs,
  inputs,
  options,
  userName,
  homeDirectory,
  userDescription,
  system,
  hostName,
  timeZone,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
