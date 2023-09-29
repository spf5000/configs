{
    # Home Manager and more inputs
    user = ; # username.
    shell = ; # shell username. Useful to distinguish things like raspberry pi vs. laptop.
    system = ; # The system (or directory with the system specific flake file) to use.
    homeDir = ; # home directory. Optional and defauls to /home/$user

    # NixOs inputs
    password = ; # user password
    SSID = ; # WIFI network;
    SSIDpassword = ; # WIFI network password;
    interface = "wlan0"; # WIFI interface name. Typically wlan0

    # DDNS inputs (raspberry pi)
    ddnsSubdomain = ""; # duck DNS subdomain.
    ddnsToken = ""; # duck DNS token.
}
