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

    # -- Host Specific --

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosConfigurations = {
        msi =
          let
            user-args = { 
              username = "ethw";
              host = "msi";
            };
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
              # Host-specific Configuration
              (import ./hosts/msi user-args)

              # Home Manager
              home-manager.nixosModules.home-manager
              (home-manager-configuration user-args)
            ];
          };
        wsl =
          let
            user-args = { 
              username = "ethw";
              host = "wsl";
            };
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
              # Host-specific Configuration
              (import ./hosts/wsl user-args)

              # WSL
              inputs.nixos-wsl.nixosModules.default

              # Home Manager
              home-manager.nixosModules.home-manager
              (home-manager-configuration user-args)
            ];
          };
      };
    };
}
