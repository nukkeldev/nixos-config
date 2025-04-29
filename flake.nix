{
  description = "Nukkel's Catppuccin Overdose";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

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
