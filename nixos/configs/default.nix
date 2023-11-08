{ ... }:

{
  imports = [
    ./networking

    ./boot.nix
    ./fonts.nix
    ./hardware.nix
    ./i18n.nix
    ./programs.nix
    ./shellAliases.nix
    ./users.nix
  ];

  time = {
    timeZone = "Asia/Taipei";
    hardwareClockInLocalTime = false;
  };

  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };

  system.stateVersion = "23.05";
}
