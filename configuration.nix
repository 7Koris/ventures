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
  imports = [
    ./hardware-configuration.nix
    #./user.nix
    ./modules/nvidia-drivers.nix
    # ./modules/nvidia-prime-drivers.nix # uncomment if on a laptop
    # ./modules/intel-drivers.nix # uncomment if intel
    inputs.home-manager.nixosModules.default
  ];

  time.timeZone = timeZone;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  programs = {
    fish.enable = true;
    niri.enable = true;
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld;
    };
    firefox.enable = false;
    dconf.enable = true;
    fuse.userAllowOther = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # substituters = [ "https://hyprland.cachix.org" ];
      # trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        userName
        homeDirectory
        userDescription
        system
        hostName
        timeZone
        ;
    };
    users.${userName} = import ./home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  system.stateVersion = "25.11";
}
