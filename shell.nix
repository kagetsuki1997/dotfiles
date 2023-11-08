{ system ? builtins.currentSystem
, pkgs ? import <nixpkgs> { inherit system; }
, nixpkgs ? import <nixpkgs> { inherit system; }
}:

pkgs.mkShell rec {

  name = "home-manager-shell";

  buildInputs = with pkgs; [
    nixVersions.stable
    git

    nixos-generators

    jq

    treefmt
    nixpkgs-fmt
    shfmt
    nodePackages.prettier

    shellcheck
  ];

  shellHook = ''
    export PATH=$PWD/dev-support/bin:$PATH
  '';
}
