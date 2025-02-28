{
  description = "Nukkel's Catppuccin Overdose";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvix
    nvix.url = "github:niksingh710/nvix";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      home-manager-configuration = args: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${args.username} = import ./home;

        home-manager.extraSpecialArgs = inputs // args;
      };
    in
    {
      nixosConfigurations = {
        msi =
          let
            username = "ethw";
            args = { inherit username; };
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
              # Host-specific Configuration
              (import ./hosts/msi args)

              # Home Manager
              home-manager.nixosModules.home-manager

              # Home Manager Configuration
              (home-manager-configuration args)
            ];
          };
      };
    };
}
