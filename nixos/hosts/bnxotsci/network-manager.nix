{ secrets, hostName, ... }:

{
  environment.etc = {
    "NetworkManager/system-connections/wifi-doge.nmconnection" =
      secrets.nixos.network-manager.${hostName}.wifi.doge;
  };
}
