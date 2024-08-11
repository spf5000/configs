# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let 
  inputs = import /home/sean/configs/nix/inputs.nix;
in {
  imports =
      [ # Include the results of the hardware scan.
          /etc/nixos/hardware-configuration.nix
      ];

    # Use the systemd boot loader.
    boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = 10;
    };
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Mount home partition
    fileSystems."/home" = {
        device = "/dev/nvme0n1p4";
    };

    # Enable ssh for remote nix builds from raspberry pi
    services.openssh.enable = false;

    # Enable OpenGL
    # hardware.opengl.enable = true;

    # # Override mesa drives to latest drivers from nixos-unstable branch (added via flake overlay).
    # hardware.opengl.extraPackages = [pkgs.unstable-mesa.drivers];
    # hardware.opengl.package = pkgs.unstable-mesa.drivers;
    # system.replaceRuntimeDependencies = [
    #     ({ original = pkgs.mesa; replacement = pkgs.unstable-mesa; })
    #     ({ original = pkgs.mesa.drivers; replacement = pkgs.unstable-mesa.drivers; })
    # ];

    # Setting package caches to speed up builds
    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        trusted-users = ["@wheel" "nixremote"];
    };

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        displayManager = {
            gdm.enable = true;
            gdm.wayland = true;
        };
    };

    # Enable sound.
    hardware.pulseaudio.enable = false;
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Enable bluetooth
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users = {
        sean = { 
            isNormalUser = true;
            description = "Sean Flinn";
            extraGroups = [ "wheel" "video" "audio" "networkmanager"]; # Enable ‘sudo’ for the user.
            password = "${inputs.password}";
        };
        nixremote = {
            description = "Remote Builder";
            isNormalUser = true;
            homeMode = "500"; 
            # TODO: Add in once we have a way to securly grant access to trusted users
            openssh.authorizedKeys.keyFiles = [];
            password = "${inputs.password}";
        };
    };

    # Prevent non-decarative users from being created.
    users.mutableUsers = false;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        gparted
        brave
        pavucontrol # volume management
        signal-desktop
        nmap
        vlc # video player
        gnome.eog # image viewer
        libheif # .heic file support from iphone
    
        # default Hyprland terminal
        kitty
    
        glxinfo

        xorg.xhost
    ];

    # Flatpak
    services.flatpak.enable = true;
  
    # Wayland session variables.
    environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OSMZONE_WL = "1";
    };
  
    # Hyperland
    # programs.hyprland = {
    #     enable = true;
    #     xwayland.enable = true;
    # };
 
    programs.xwayland.enable = true;

    # Sway
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

    programs.steam.enable = true;
  
    # Wayland screen sharing
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}

