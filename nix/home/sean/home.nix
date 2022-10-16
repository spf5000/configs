{ config, pkgs, ... }:

{
  imports = 
    [
      ./nvim.nix
      ./tmux.nix
      ./fish.nix
      ./zsh.nix
    ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sean";
  home.homeDirectory = "/home/sean";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages
  home.packages = with pkgs; [
    alacritty
    neofetch
    figlet
    xclip
    tmux
    dmenu
    rofi
    calcurse
    font-awesome
    brightnessctl
    # fractal # matrix
    # signal-desktop
    firefox

    # Nix Utils
    nix-prefetch-github

    # Rust
    rustc
    cargo
    rust-analyzer

    # Rust Apps
    lsd
    bat
    ripgrep
  ];

  programs.git = {
    enable = true;
    userName = "Sean Flinn";
    userEmail = "sflinn54@gmail.com";
  };

  # manage fonts via home manager
  fonts.fontconfig.enable = true;

  # dotfiles. See github: https://github.com/spf5000/configs
  xdg.configFile."alacritty".source = ~/configs/.config/alacritty;
  xdg.configFile."sway".source = ~/configs/.config/sway;
  xdg.configFile."swaylock".source = ~/configs/.config/swaylock;
  xdg.configFile."qtile".source = ~/configs/.config/qtile;
}
