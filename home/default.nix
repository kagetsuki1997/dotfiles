{ self
, nixpkgs
, home-manager
, sops-nix
, fenix
, nix-repo
, ...
}:

let
  hmConfiguration =
    { system ? "x86_64-linux"
    , user ? "kagetsuki"
    , home ? "/home"
    , extraModules ? [ ]
    , enableRemoteNixBuilders ? true
    , enableHiDPI ? false
    , withBrowsers ? true
    , withMultimedia ? true
    , withGraphics ? true
    , withMobile ? false
    , withDownloaders ? true
    , withTor ? true
    , withNetworkBenchmarks ? true
    , withIDEs ? true
    , withVirtualisationGUISupports ? true
    , screenlayoutScript ? (builtins.readFile ./modules/desktop/config/screenlayout/default.sh)
    }:

    (home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};

      modules = [
        {
          home = {
            username = "${user}";
            homeDirectory = "${home}/${user}";
            stateVersion = "23.05";
          };

          imports = [
            # ./sops.nix
            # sops-nix.nixosModules.sops
          ] ++ extraModules;

          nixpkgs = {
            overlays =
              self.overlays ++ [
                fenix.overlays.default
              ];
            config = {
              allowUnfree = true;
              oraclejdk.accept_license = true;
              android_sdk.accept_license = true;
            };
          };
        }
      ];

      extraSpecialArgs = {
        inherit
          fenix
          enableRemoteNixBuilders
          enableHiDPI
          withBrowsers
          withMultimedia
          withGraphics
          withMobile
          withDownloaders
          withTor
          withNetworkBenchmarks
          withIDEs
          withVirtualisationGUISupports
          screenlayoutScript;
      };
    });
in
{
  "kagetsuki@nixosvm" = hmConfiguration {
    screenlayoutScript = builtins.readFile ./hosts/nixosvm/desktop/config/screenlayout/single.sh;
    extraModules = [ ./hosts/nixosvm/default.nix ];
  };

  "jacklin@macbook" = hmConfiguration {
    system = "aarch64-darwin";
    user = "jacklin";
    home = "/Users";
    withBrowsers = false;
    withMultimedia = false;
    withMobile = false;
    withDownloaders = false;
    extraModules = [ ./hosts/nixosvm/default.nix ];
  };

  # "user@axrytxnf" = hmConfiguration {
  #   screenlayoutScript = builtins.readFile ./hosts/axrytxnf/desktop/config/screenlayout/dual.sh;
  #   extraModules = [ ./hosts/axrytxnf/default.nix ];
  # };

  # "user@bnxotsci" = hmConfiguration {
  #   screenlayoutScript = builtins.readFile ./hosts/bnxotsci/desktop/config/screenlayout/dual.sh;
  #   extraModules = [ ./hosts/bnxotsci/default.nix ];
  # };

  # "user@vapmiehc" = hmConfiguration {
  #   enableHiDPI = true;
  #   extraModules = [ ./hosts/vapmiehc/default.nix ];
  # };

  # "user@xapekcim" = hmConfiguration {
  #   enableRemoteNixBuilders = false;
  #   screenlayoutScript = builtins.readFile ./hosts/xapekcim/desktop/config/screenlayout/single.sh;
  #   extraModules = [ ./hosts/xapekcim/default.nix ];
  # };
}
