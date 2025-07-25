{
  config,
  pkgs,
  ...
}: {
  # Home Manager
  home.username = "tpickup";
  home.homeDirectory = "/home/tpickup";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  # Bash Configuration
  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sh ~/.dotfiles/rebuild.sh"; # Rebuilds NixOS
      fdn = "nano ~/.dotfiles/flake.nix";
      hdn = "nano ~/.dotfiles/home.nix";
      cdn = "nano ~/.dotfiles/configuration.nix";
    };

    initExtra = ''
      export PS1='\[\e[36m\]\u\[\e[0m\] in \[\e[38;5;217m\]\w\[\e[0m\] \\$ '
    '';
  };

  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland.enable = true; # enable Hyprland

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind =
      [
        "$mod, F, exec, firefox"
        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
  };
  # Git config
  programs.git = {
    enable = true;

    userName = "Thomas";
    userEmail = "thomas@pckp.net";
  };

  # User Specific Packages
  home.packages = with pkgs; [
    bat
  ];
}
