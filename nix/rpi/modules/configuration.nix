{ config, pkgs, lib, inputs, ... }:

let 
  hidden-inputs = import /home/sean/configs/nix/inputs.nix;
in {
  imports = [
    # "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/raspberry-pi/4"
    # "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/modules/age.nix"
    ./remote-builder.nix
    ./docker.nix
    ./omada-controller.nix
    ./home-assistant.nix
    ./vpn.nix
    # ./ddns.nix
  ];

  # age.secrets.userPass.file = ../../secrets/userPass.agenix;
  system.stateVersion = "22.11";

  boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
      initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
      loader = {
          grub.enable = false;
          generic-extlinux-compatible.enable = true;
      };
  };

  # fileSystems = {
  #   "/" = {
  #     device = "/dev/disk/by-label/NIXOS_SD";
  #     fsType = "ext4";
  #     options = [ "noatime" ];
  #   };
  # };

  ## Setup wifi if needed.
  networking = {
    hostName = "${hidden-inputs.hostname}";
    wireless = {
      enable = true;
      networks."${hidden-inputs.SSID}".psk = "${hidden-inputs.SSIDpassword}";
      interfaces = [ "${hidden-inputs.interface}"];
    };
  };

  # environment.systemPackages = with pkgs; [ 
  #     (pkgs.callPackage "${builtins.fetchTarball "https://github.com/ryantm/agenix/archive/main.tar.gz"}/pkgs/agenix.nix" {})
  # ];

  services.openssh.enable = true;

  users = {
    mutableUsers = false;
    # defaultUserShell = pkgs.zsh;
    users."${hidden-inputs.user}" = {
      isNormalUser = true;
      password = "${hidden-inputs.password}";
      # passwordFile = config.age.secrets.userPass.path;
      extraGroups = [ "wheel" "podman" ];
    };
  };

  # Enable GPU acceleration
  hardware.enableRedistributableFirmware = true;

  # TODO: See if this is actually needed.
  # hardware.pulseaudio.enable = false;
}
