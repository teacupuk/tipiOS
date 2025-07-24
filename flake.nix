{
	description = "tipiOS";
	
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
	};
	
	outputs = {self, nixpkgs, ...}:
	let 
		lib = nixpkgs.lib;
	in
	 {
		nixosConfigurations = {
			nix01 = lib.nixosSystem {
				system = "aarch64-linux";
				modules = [
					./configuration.nix	
				];
			};
		};
	};
}
