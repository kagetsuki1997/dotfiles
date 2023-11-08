{ pkgs
, withDownloaders
, withTor
, withNetworkBenchmarks
, ...
}:

let
  common = with pkgs; [
    socat
    netcat-gnu

    wireguard-tools

    nmap
    tcpdump
    iptstate

    httpx
    httpie
    inetutils
    xh

    miniserve

    ipfs
    lftp

    brook

    dogdns

    extra.tunelo
  ];

  ssh-related = with pkgs; [
    rsync
    sshfs-fuse
    sshuttle
    autossh

    ssh-tools
  ];

  downloaders = with pkgs; [
    aria2
    axel
    megatools
    youtube-dl

    extra.aria2rpc
    extra.megadecrypter
    extra.gdv-dl
  ];

  tor-related = with pkgs; [
    tor
    torsocks
  ];

  benchmarks = with pkgs; [
    siege
    iperf
    speedtest-cli
  ];

in
{
  config = {
    home.packages =
      common
      ++ ssh-related
      ++ (if withDownloaders then downloaders else [ ])
      ++ (if withTor then tor-related else [ ])
      ++ (if withNetworkBenchmarks then benchmarks else [ ]);

    home.file = {
      ".local/bin/magnet-handler".source = ./bin/magnet-handler;
    };

    xdg.configFile = {
      "aria2/aria2.daemon.conf".source = ./config/aria2/aria2.daemon.conf;
      "youtube-dl/config".source = ./config/youtube-dl/config;
    };
  };
}
