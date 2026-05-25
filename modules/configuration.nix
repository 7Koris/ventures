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
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        runAsRoot = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

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
    users.${userName} = import ../home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
  };

  drivers.nvidia.enable = true;
  system.stateVersion = "25.11";
}
