{ pkgs, ... }:

{
  # users.extraUsers.user = secrets.nixos.users.user;

  users.users.kagetsuki = {
    isNormalUser = true;
    description = "kagetsuki";
    extraGroups = [ "networkmanager" "wheel" ];
  };


  users.defaultUserShell = "${pkgs.zsh}/bin/zsh";
}
