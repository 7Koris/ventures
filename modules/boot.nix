{
  config,
  pkgs,
  userName,
  homeDirectory,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    kernelParams = [
      "intel_pstate=active"
      "i915.enable_psr=1" # Panel self refresh
      "i915.enable_fbc=1" # Framebuffer compression
      "i915.enable_dc=2" # Display power saving
      # "nvme.noacpi=1"
      "nvidia-drm.modeset=1"
      # "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "pcie_aspm=off"
    ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
    tmp = {
      useTmpfs = true;
      tmpfsSize = "10G";
    };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
}
