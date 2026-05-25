{
  description = "Ventures flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      spicetify-nix,
      stylix,
      niri,
      ...
    }@inputs:
    let
      userName = "koris";
      homeDirectory = "/home/${userName}";
      userDescription = "";
      system = "x86_64-linux";
      hostName = "ventures";
      timeZone = "US/Pacific";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
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
        modules = [
          ./modules/configuration.nix
          inputs.home-manager.nixosModules.default
          stylix.nixosModules.stylix
          ./modules/noctalia.nix
          ./modules/networking.nix
          ./modules/boot.nix
          ./modules/system-packages.nix
          ./modules/services.nix
          ./modules/security.nix
          ./modules/style.nix
          ./modules/default-applications.nix
          ./modules/user.nix
          ./modules/hardware.nix
          ./modules/fonts.nix
          ./modules/nix-config.nix
          ./modules/hardware-configuration.nix
          ./modules/vm-guest-services.nix

          # Drivers (change for your system)
          ./modules/nvidia-drivers.nix
          # ./nvidia-prime-drivers.nix # uncomment for laptop
          #./intel-drivers.nix
          #./amd-drivers.nix
        ];
      };
    };
}
