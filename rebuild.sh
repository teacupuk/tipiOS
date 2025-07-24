# A rebuild script that commits on a successful build
set -e

# cd to your config dir
pushd ~/.dotfiles/

# Early return if no changes were detected (thanks @singiamtel!)
if git diff --quiet '*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

# Autoformat your nix files
alejandra . &>/dev/null \
  || ( alejandra . ; echo "formatting failed!" && exit 1)

echo "NixOS Rebuilding..."

nix flake update &>nixos-flake.log || (cat nixos-flake.log | grep --color error && exit 1)

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch --flake . &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

home-manager switch --flake . &>home-switch.log || (cat home-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

git push
# Back to where you were
popd
