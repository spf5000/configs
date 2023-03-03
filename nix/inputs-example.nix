{
    # Home Manager and more inputs
    user = ; # username.
    homeDir = ; # home directory. Optional and defauls to /home/$user
    shell = ; # shell username. Useful to distinguish things like raspberry pi vs. laptop.
    systemPath = ; # Set to the directory storing the nixos configuration.nix file. Ex: rpi / system

    # NixOs inputs
    password = ; # user password
    SSID = ; # WIFI network;
    SSIDpassword = ; # WIFI network password;
    interface = "wlan0"; # WIFI interface name. Typically wlan0
    hostname = ; # hostname of the device
}
