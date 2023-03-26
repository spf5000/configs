{ config, pkgs, ... }:

let
    inputs = import ../inputs.nix;
in {
    systemd.timers."dyndns" = {
      wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "5m";
          OnUnitActiveSec = "5m";
          Unit = "dyndns.service";
        };
    };

    systemd.services."dyndns" = {
      script = "echo url=\"https://www.duckdns.org/update?domains=${inputs.ddnsSubdomain}&token=${inputs.ddnsToken}&ip=\" | ${pkgs.curl}/bin/curl -k -K -";
      serviceConfig = {
        Type = "oneshot";
        User= "nobody";
      };
    };
}
