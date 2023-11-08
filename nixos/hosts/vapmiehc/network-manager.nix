{ secrets, hostName, ... }:

{
  environment.etc = {
    "NetworkManager/system-connections/vpn-fst-network.nmconnection" =
      secrets.nixos.network-manager.${hostName}.vpn.fst-network;

    "NetworkManager/system-connections/wifi-fst-network.nmconnection" =
      secrets.nixos.network-manager.${hostName}.wifi.fst-network;
  };
}
