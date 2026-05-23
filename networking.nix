{
  config,
  pkgs,
  options,
  hostName,
  ...
}:
{
  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      allowedTCPPorts = [ 8003 ];
      checkReversePath = "loose";
    };
  };
}
