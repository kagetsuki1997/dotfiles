{ config, lib, pkgs, hostName, ... }:

{

  environment.etc = {
    "ssh/server/keys/ed25519_key" = secrets.nixos.ssh.server.${hostName}.ed25519.privateKey;
    "ssh/server/keys/ed25519_key.pub" = secrets.nixos.ssh.server.${hostName}.ed25519.publicKey;
    "ssh/server/keys/rsa_key" = secrets.nixos.ssh.server.${hostName}.rsa.privateKey;
    "ssh/server/keys/rsa_key.pub" = secrets.nixos.ssh.server.${hostName}.rsa.publicKey;
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;

    hostKeys = [
      {
        path = "/etc/ssh/server/keys/ed25519_key";
        type = "ed25519";
      }
      {
        bits = 4096;
        path = "/etc/ssh/server/keys/rsa_key";
        type = "rsa";
      }
    ];

    extraConfig = ''
      IgnoreRhosts yes
    '';

  };
}
