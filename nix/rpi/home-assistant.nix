{ pkgs, ... }:
{
    # Copy home-assistant files to /var/home-assistant to be used as (writable) volume path.
    system.activationScripts.home-assistant-setup.text =
    ''
      # TODO: I should generalize this path
      volume_path=$(${pkgs.podman}/bin/podman volume inspect --format "{{.Mountpoint}}" home-assistant)
      cp -rf /home/sean/configs/home-assistant/* $volume_path
    '';

    # Expose ports in the firewall
    networking.firewall = {
        allowedTCPPorts = [ 
            8123
            21063 # homekit port
        ];
        allowedUDPPorts = [
            5353 # homekit port
        ];
    };

    # Setup home-assistant docker container
    virtualisation.oci-containers.containers.home-assistant = {
        image = "docker.io/homeassistant/home-assistant:2023.2";
        autoStart = true;
        environment.TZ = "Europe/Berlin";
        volumes = [ "home-assistant:/config" ];
        extraOptions = [ 
            "--network=host"
            "--device=/dev/ttyUSB0:/dev/ttyUSB0"
            "--device=/dev/ttyUSB1:/dev/ttyUSB1"
        ];
    };
}
