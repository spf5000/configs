{ pkgs, ... }:
{
    # Add podman compose for testing.
    environment.systemPackages = with pkgs; [
        podman-compose
    ];

    # Expose docker ports to external (ethernet) interface.
    # NOTE: You will still need to expose the ports in the firewall per container.
    networking = {
        nat = {
            enable = true;
            internalInterfaces = ["ve-+"];
            externalInterface = "eth0";
            # Lazy IPv6 connectivity for the container
            enableIPv6 = true;
        };
    };

    virtualisation = {
        podman = {
            enable = true;

            # "docker" alias for podman
            dockerCompat = true;

            # Required for containers under podman-compose to be able to talk to each other.
            defaultNetwork.dnsname.enable = true;
        };
        oci-containers.backend = "podman";
    };
}
