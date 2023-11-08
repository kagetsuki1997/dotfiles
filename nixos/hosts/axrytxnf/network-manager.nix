{ secrets, hostName, ... }:

{
  environment.etc = {
    "NetworkManager/system-connections/ethernet-fst-network.nmconnection" =
      secrets.nixos.network-manager.${hostName}.ethernet.fst-network;

    "NetworkManager/system-connections/wifi-karti.nmconnection" =
      secrets.nixos.network-manager.${hostName}.wifi.doge;
  };
}
