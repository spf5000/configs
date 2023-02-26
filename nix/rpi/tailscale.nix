{ config, pkgs, ... }:

{
    # Enable Tailscale daemon
    services.tailscale = {
        enable = true;
    };

    # Setup magic DNS
    networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
    networking.search = [ "tail06baf.ts.net" ];

    # Open UDP port used by tailscale.
    # networking.firewall = {
    #     enable = true;
    #     # trustedInterfaces = [ "tailscale0" ];
    #     allowedUDPPorts = [ config.services.tailscale.port ];
    #     # checkReversePath = "loose";

    # };

    # Disable ssh port. ssh should be done through tailscale instead.
    # services.openssh.openFirewall = false;

    # Make tailscale binary available to all users.
    environment.systemPackages = [ pkgs.tailscale ];
}
