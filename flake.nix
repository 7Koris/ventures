{
  description = "Koris flake";
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
      hostName = "mangata";
      timeZone = "US/Pacific";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.mangata = nixpkgs.lib.nixosSystem {
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
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          stylix.nixosModules.stylix
          ./noctalia.nix
          ./networking.nix
          ./boot.nix
          ./packages.nix
          ./services.nix
          ./security.nix
          ./style.nix
          ./default-applications.nix
          ./user.nix
        ];
      };
    };
}
