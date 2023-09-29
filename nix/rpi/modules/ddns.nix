{ config, pkgs, ... }:
{
    age.secrets.ddnsToken.file = ../../secrets/ddnsToken.agenix;
    systemd.timers."dyndns" = {
      wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "5m";
          OnUnitActiveSec = "5m";
          Unit = "dyndns.service";
        };
    };

    systemd.services."dyndns" = {
      environment = { 
          # TODO: This is an anti-pattern. Should find a way to pull this without readFile
          TOKEN = pkgs.lib.fileContents config.age.secrets.ddnsToken.path;
      };
      script = ''
          echo url="https://www.duckdns.org/update?domains=spf5000&token=$TOKEN&ip=" | ${pkgs.curl}/bin/curl -k -K -
      '';
      serviceConfig = {
        Type = "oneshot";
        User= "nobody";
      };
    };
}
