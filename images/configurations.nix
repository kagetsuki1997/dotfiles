{ self, nixos-generators, nixpkgs, home-manager, ... }:

let
  imageConfiguration =
    { system ? "x86_64-linux"
    , format
    , hostName ? "nixos"
    , extraModules ? [ ]
    , enableRemoteBuildMachines ? false
    }:

    (nixos-generators.nixosGenerate {
      inherit
        system
        format;

      specialArgs = {
        inherit
          home-manager
          hostName
          enableRemoteBuildMachines;

        overlays = self.overlays;
      };

      modules = [ ./base.nix ] ++ extraModules;
    });
in
{
  iso = imageConfiguration {
    format = "iso";
  };

  vm = imageConfiguration {
    format = "vm";
  };

  virtualbox = imageConfiguration {
    format = "virtualbox";
  };
}
