# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm = {
        enable = true;
        wayland = true;
    };

    # desktopManager = {
    #   xterm.enable = false;
    # };
    # layout = "us";

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sean = { 
    isNormalUser = true;
    description = "Sean Flinn";
    extraGroups = [ "wheel" "video" "audio" "networkmanager"]; # Enable ‘sudo’ for the user.
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gparted
    pavucontrol # volume management

    # default Hyprland terminal
    kitty
  ];

  # Hyperland
  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
  };
  # Wayland session variables.
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OSMZONE_WL = "1";
  };
  # # Wayland screen sharing
  # xdg.portal = {
  #     enable = true;
  #     extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };

  # Sway WM
  # programs.sway = {
  #   enable = true;
  #   xwayland.enable = true;
  #   wrapperFeatures.gtk = true;
  #   extraPackages = with pkgs; [
  #     swaylock
  #     swayidle
  #     wl-clipboard
  #     mako # notifcation daemon
  #     wofi # launcher
  #   ];
  #   extraSessionCommands = ''
  #     export SDL_VIDEODRIVER=wayland
  #     export QT_QPA_PLATFORM=wayland
  #     export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
  #     export _JAVA_AWS_WM_NONREPARENTING=1
  #     export MOZ_ENABLE_WAYLAND=1
  #   '';
  # };
  # programs.light.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

