{ pkgs, ... }:
{
    # Copy home-assistant files to /var/home-assistant to be used as (writable) volume path.
    system.activationScripts.home-assistant-setup.text =
    ''
      # TODO: I should generalize this path
      volume_path=$(${pkgs.podman}/bin/podman volume inspect --format "{{.Mountpoint}}" home-assistant)
      cp -rf /home/sean/configs/home-assistant/* $volume_path
    '';

    # Setup home-assistant docker container
    virtualisation.oci-containers.containers.home-assistant = {
        image = "docker.io/homeassistant/home-assistant:2023.2";
        autoStart = true;
        environment.TZ = "Europe/Berlin";
        # volumes = [ "/var/home-assistant:/config" ];
        volumes = [ "home-assistant:/config" ];
        # extraOptions = [ 
        #     "--network=host" 
        # ];
        ports = [
            "8123:8123"
            "40000:40000"
            "58035:58035/udp"
            "58320:58320/udp"
            "5353:5353/udp"
            "1900:1900/udp"
            "1900:1900/udp"
            "43727:43727/udp"

            # homekit ports
            "5353:5353/udp"
            "21063:21063"
        ];
    };
}
