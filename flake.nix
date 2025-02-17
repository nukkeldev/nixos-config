{
  description = "Nukkel's NixOS Configuration";

  inputs = {
    # Nix Packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Waybar
    waybar = {
      url = "github:Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Vim
    nixvim = {
        url = "github:nix-community/nixvim/nixos-24.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      john = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	
	modules = [
          ./hosts/john.nix 
          home-manager.nixosModules.home-manager
	  {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ethw = import ./home;

	    home-manager.extraSpecialArgs = { inherit inputs; };
          }
	];
      };
    };
  };
}
