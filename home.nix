{ config, pkgs, ... }:

{
	# Home Manager
	home.username = "tpickup";
	home.homeDirectory = "/home/tpickup";
	home.stateVersion = "25.05";

	# Bash Configuration
	programs.bash = {
		enable = true;
		shellAliases = {
			nrs = "sudo nixos-rebuild switch";
			hdn = "sudo nano ~/.dotfiles/home.nix";
			cdn = "sudo nano ~/.dotfiles/configuration.nix";
		};
		
		initExtra = ''
			export PS1='\[\e[36m\]\u\[\e[0m\] in \[\e[38;5;217m\]\w\[\e[0m\] \\$ '
		'';
			
	};

	# Alacritty Terminal Settings
	programs.alacritty = {
		enable = true;
		settings = { 
			window.opacity = 0.9;
		};
	};

	# User Specific Packages
	home.packages = with pkgs; [
		bat
	];
}
