{ config, pkgs, ... }:

let
    wireguard_port = 51820;
    inputs = import ../inputs.nix;
in {

    environment.systemPackages = with pkgs; [ 
        wireguard-tools
    ];

    # enable NAT
    # networking.nat = {
    #     enable = true;
    #     externalInterface = "eth0";
    #     internalInterfaces = ["wg0"];
    # };

    # Open wireguard port.
    networking.firewall.allowedUDPPorts = [ wireguard_port ];

    # Setup wireguard interface
    networking.wireguard.interfaces = {
        # "wg0" is the network interface name. You can name the interface arbitrarily.
        wg0 = {
            # Determines the IP address and subnet of the server's end of the tunnel interface.
            ips = [ "10.0.0.1/24" ];
  
            # The port that WireGuard listens to. Must be accessible by the client.
            listenPort = wireguard_port;
  
            # # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
            # # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
            # postSetup = ''
            #   ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
            # '';
  
            # # This undoes the above command
            # postShutdown = ''
            #   ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
            # '';
  
            # Path to the private key file.
            #
            # Note: The private key can also be included inline via the privateKey option,
            # but this makes the private key world-readable; thus, using privateKeyFile is
            # recommended.
            # TODO automate this configuration
            # privateKeyFile = toString (if inputs ? homeDir then inputs.homeDir else /home + inputs.user) + "/wireguard-keys/private";
            privateKeyFile = "/home/sean/wireguard-keys/server.key";
  
            peers = [
              # List of allowed peers.
              { # Laptop
                publicKey = "19eEK592Cwv4ft6dSuWUB+sOVHYOr27IECjbnuvybg8=";
                # TODO automate this configuration
                presharedKeyFile = "/home/sean/wireguard-keys/laptop-server.psk";
                allowedIPs = [ "10.0.0.2/32" ];
              }
              { # Phone
                publicKey = "P2R4IoKV5VsdewnLbNmvJ/R0wZFJWBZfuIuqyyrjWTw=";
                # TODO automate this configuration
                presharedKeyFile = "/home/sean/wireguard-keys/iphone-server.psk";
                allowedIPs = [ "10.0.0.3/32" ];
              }
            ];
        };
    };
}
