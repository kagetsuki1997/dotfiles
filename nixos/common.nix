{ pkgs, sops, ... }:

{
  imports = [
    ./configs
    ./containers
    ./services
  ]
  ++ (import ../nixpkgs/nixos/modules/module-list.nix);
}
