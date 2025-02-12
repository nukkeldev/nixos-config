{
  description = "Nukkel's NixOS Configuration";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  
    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      john = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	
	modules = [
          ./hosts/john.nix 
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ethw = import ./home;
          }
	];
      };
    };
  };
}
