{
  config,
  pkgs,
  userName,
  homeDirectory,
  ...
}:
{
  hardware = {
    enableRedistributableFirmware = true;
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics.enable = true;
  };
}
