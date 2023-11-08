{ secrets, ... }:

{
  services.openvpn.servers = {
    # fstnetwork = secrets.vpn.openvpn.fstnetwork-specified;
  };
}
