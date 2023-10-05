{ pkgs, ... }:
{
    # Expose ports in the firewall
    networking = {
        firewall = {
            allowedTCPPorts = [ 
                8088
                8043
                8843
                29811
                29812
                29813
                29814
            ];
            allowedUDPPorts = [
                27001
                29810
            ];
        };
    };

    virtualisation.oci-containers.containers.omada-controller = {
        image = "docker.io/mbentley/omada-controller:5.7";
        autoStart = true;
        extraOptions = [ 
            "--network=host" 
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
}
