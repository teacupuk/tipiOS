{
  description = "tipiOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "aarch64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # System Level Config
    nixosConfigurations = {
      nix01 = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };

    # User Level Config
    homeConfigurations = {
      tpickup = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [./home.nix];
      };
    };
  };
}
