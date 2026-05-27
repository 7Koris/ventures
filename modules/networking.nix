{
  config,
  pkgs,
  options,
  hostName,
  ...
}:
{
  networking = {
    #wireless.enable = true;
    hostName = hostName;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    nameservers = [ "8.8.8.8" "1.1.1.1" ]; 
    networkmanager.dns = "none"; 
    firewall = {
      #allowedTCPPorts = [ 8003 ];
      checkReversePath = "loose";
    };
  };
}
