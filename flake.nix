{
  description = "NixOS and Home Manager Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-repo = {
      url = "github:xrelkd/nix-repo";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nixos-generators
    , sops-nix
    , nix-repo
    , flake-utils
    , fenix
    }:
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell = pkgs.callPackage ./shell.nix { inherit nixpkgs; };

        apps = {
          hm-build = {
            type = "app";
            program = toString (pkgs.writeScript "hm-build" ''
              #!${pkgs.runtimeShell}

              export NIXPKGS_ALLOW_UNFREE=1
              profile=''${1:-$USER@$(hostname)}

              nix build --impure --no-link --show-trace --json .#homeManagerConfigurations.$profile.activationPackage | jq -r '.[] | .outputs | .out'
            '');
          };

          hm-switch = {
            type = "app";
            program = toString (pkgs.writeScript "hm-switch" ''
              #!${pkgs.runtimeShell}

              set -eu -o pipefail -x

              cd ${./.}

              $(nix run .#hm-build -- "$@")/activate
            '');
          };
        };

      }
      ) // {
      overlays = [
        (final: prev: (import ./nixpkgs) final prev)
        nix-repo.overlay
      ];

      nixosConfigurations = import ./nixos {
        inherit self nixpkgs home-manager sops-nix nix-repo;
      };

      homeManagerConfigurations = import ./home {
        inherit self nixpkgs home-manager sops-nix fenix nix-repo;
      };

      # images = import ./images {
      #   inherit self nixos-generators nixpkgs home-manager sops-nix nix-repo;
      # };

    };
}
