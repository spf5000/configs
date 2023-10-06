{ config, pkgs, ... }:
{
    nix = {
        buildMachines = [{
            hostName = "nixremote@192.168.0.19";
            systems = [ "x86_64-linux" ];
            protocol = "ssh";
            maxJobs = 4;
            speedFactor = 2;
            # supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
        }];
        distributedBuilds = true;
        extraOptions = ''
            builders-use-substitutes = true
        '';
    };

}
