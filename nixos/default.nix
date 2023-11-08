{ self
, nixpkgs
, home-manager
, sops-nix
, nix-repo
, ...
}:

let
  nixosConfiguration =
    { system ? "x86_64-linux"
    , extraModules ? [ ]
    , hostName
    , enableRemoteBuildMachines ? false
    }:

    (nixpkgs.lib.nixosSystem {
      inherit system;

      modules = extraModules ++ [
        sops-nix.nixosModules.sops

        { nixpkgs.overlays = self.overlays; }
      ];

      specialArgs = rec {
        inherit
          home-manager
          hostName
          enableRemoteBuildMachines;
      };
    });
in
{
  nixosvm = nixosConfiguration {
    hostName = "nixosvm";
    extraModules = [ ./hosts/nixosvm/configuration.nix ];
  };

  # axrytxnf = nixosConfiguration {
  #   hostName = "axrytxnf";
  #   extraModules = [ ./hosts/axrytxnf/configuration.nix ];
  # };

  # bnxotsci = nixosConfiguration {
  #   hostName = "bnxotsci";
  #   extraModules = [ ./hosts/bnxotsci/configuration.nix ];
  # };

  # vapmiehc = nixosConfiguration {
  #   hostName = "vapmiehc";
  #   extraModules = [ ./hosts/vapmiehc/configuration.nix ];
  # };

  # xapekcim = nixosConfiguration {
  #   hostName = "xapekcim";
  #   enableRemoteBuildMachines = false;
  #   extraModules = [ ./hosts/xapekcim/configuration.nix ];
  # };
}
