{
  config,
  pkgs,
  userName,
  homeDirectory,
  ...
}:
{
  services = {
    blueman.enable = true;
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [ "nvidia" ];
    };

    displayManager.ly = {
      enable = true;
      settings = {
        animate = true;
        animation = "colormix";
      };
    };

    logind = {
      settings.Login = {
        HandlePowerKey = "suspend";
      };
    };

    cron = {
      enable = true;
    };
    libinput.enable = true;
    upower.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    power-profiles-daemon.enable = false;
    thermald.enable = true;
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    syncthing = {
      enable = true;
      user = userName;
      dataDir = homeDirectory;
      configDir = "${homeDirectory}/.config/syncthing";
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
