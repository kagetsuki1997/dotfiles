{ pkgs
, home-manager
# , sops
, enableRemoteBuildMachines
, ...
}:

{
  nix = {
    nixPath = [
      "nixpkgs=${pkgs.path}"
      "home-manager=${home-manager}"
    ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      builders-use-substitutes = true
      experimental-features = nix-command flakes
    '';

    settings = {
      cores = 0;
      # access-token = "github.com=${sops.secrets.github_token}";

      substituters = [
        "https://aseipp-nix-cache.freetls.fastly.net"
        "https://aseipp-nix-cache.global.ssl.fastly.net"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [ ];

      sandbox = true;
      trusted-users = [ "root" "kagetsuki" "@wheel" ];
      trusted-binary-caches = [
        "https://aseipp-nix-cache.freetls.fastly.net"
        "https://aseipp-nix-cache.global.ssl.fastly.net"
        "https://cache.nixos.org"
      ];
    };

    distributedBuilds = true;

    buildMachines =
      if enableRemoteBuildMachines then
        [
          {
            # hostName = "fst-noah";
            # sshUser = "user";
            # sshKey = "/etc/keyfiles/nix-builders/fst/fst-id_ed25519";
            # system = "x86_64-linux";
            # speedFactor = 1;
            # maxJobs = 16;
            # supportedFeatures = [ "kvm" "nixos-test" "benchmark" "big-parallel" ];
            # mandatoryFeatures = [ ];
          }
        ]
      else [ ];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };
}
