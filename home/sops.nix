{ config
, ...
}:

{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    secrets = {
      "github_token" = { };
      "ssh_key" = { };
    };
  };
}
