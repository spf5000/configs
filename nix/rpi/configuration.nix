{ config, pkgs, lib, ... }:

let 
  inputs = import /home/sean/configs/nix/inputs.nix;
in {
  imports = ["${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"];

  system.stateVersion = "22.11";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    hostName = "${inputs.hostname}";
    wireless = {
      enable = true;
      networks."${inputs.SSID}".psk = "${inputs.SSIDpassword}";
      interfaces = [ "${inputs.interface}"];
    };
  };

  environment.systemPackages = with pkgs; [ vim ];

  services.openssh.enable = true;

  users = {
    mutableUsers = false;
    users."${inputs.user}" = {
      isNormalUser = true;
      password = "${inputs.password}";
      extraGroups = [ "wheel" ];
    };
  };


  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  hardware.pulseaudio.enable = false;
}
