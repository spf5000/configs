{ pkgs, ... }:
{
    # imports = [ arion.nixosModules.arion ];
    environment.systemPackages = with pkgs; [
        podman-compose
    ];

    virtualisation = {
        podman = {
            enable = true;
            dockerCompat = true;
            # dockerSocket.enable = true;

            # Required for containers under podman-compose to be able to talk to each other.
            defaultNetwork.dnsname.enable = true;
        };
        oci-containers.backend = "podman";
        oci-containers.containers = {
            omada-controller = {
                image = "docker.io/mbentley/omada-controller:5.7";
                autoStart = true;
                ports = [
                    "8088:8088"
                    "8043:8043"
                    "8843:8843"
                    "27001:27001/udp"
                    "29810:29810/udp"
                    "29811:29811"
                    "29812:29812"
                    "29813:29813"
                    "29814:29814"
                ];
                environment = {
                    PUID = "508";
                    PGID = "508";
                    MANAGE_HTTP_PORT = "8088";
                    MANAGE_HTTPS_PORT = "8043";
                    PORTAL_HTTP_PORT = "8088";
                    PORTAL_HTTPS_PORT = "8843";
                    PORT_APP_DISCOVERY = "27001";
                    PORT_DISCOVERY = "29810";
                    PORT_MANAGER_V1 = "29811";
                    PORT_ADOPT_V1 = "29812";
                    PORT_UPGRADE_V1 = "29813";
                    PORT_MANAGER_V2 = "29814";
                    SHOW_SERVER_LOGS = "true";
                    SHOW_MONGODB_LOGS = "false";
                    SSL_CERT_NAME = "tls.crt";
                    SSL_KEY_NAME = "tls.key";
                    TZ = "Etc/UTC";
                };
                volumes = [
                    "omada-data:/opt/tplink/EAPController/data"
                    "omada-logs:/opt/tplink/EAPController/logs"
                ];
            };
        };
    };
}
