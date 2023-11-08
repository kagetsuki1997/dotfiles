{ config, lib, pkgs, ... }:

{
  services.timesyncd = {
    servers = [
      "time.stdtime.gov.tw"
      "tock.stdtime.gov.tw"
      "watch.stdtime.gov.tw"
      "clock.stdtime.gov.tw"
      "tick.stdtime.gov.tw"

      "time1.google.com"
      "time2.google.com"
      "time3.google.com"
      "time4.google.com"

      "0.nixos.pool.ntp.org"
      "1.nixos.pool.ntp.org"
      "2.nixos.pool.ntp.org"
      "3.nixos.pool.ntp.org"

      "0.arch.pool.ntp.org"
      "1.arch.pool.ntp.org"
      "2.arch.pool.ntp.org"
      "3.arch.pool.ntp.org"
    ];
  };
}
