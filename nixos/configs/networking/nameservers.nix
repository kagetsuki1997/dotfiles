{ config, lib, pkgs, ... }:

{
  networking.nameservers = [
    "1.1.1.1" # Cloudflare DNS
    "1.0.0.1" # Cloudflare DNS
    "8.8.4.4" # Google DNS
    "8.8.8.8" # Google DNS
    "9.9.9.9" # IBM DNS
    "208.67.222.222" # OpenDNS
    "208.67.220.220" # OpenDNS
    # "168.95.1.1"          # HiNet DNS
    # "168.95.192.1"        # HiNet DNS
  ];
}

