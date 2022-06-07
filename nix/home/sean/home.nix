{ config, pkgs, ... }:

{
  imports = 
    [
      ./nvim.nix
      ./tmux.nix
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
  ];

  programs.git = {
    enable = true;
    userName = "Sean Flinn";
    userEmail = "sflinn54@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";
    shellAliases = {
      system-update = "sudo nixos-rebuild switch --upgrade";
      home-update = "nix-channel --update && home-manager switch -f ~/configs/nix/home/sean/home.nix";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    initExtra = ''
      set -o vi
      PS1='%B%F{043}%n %fin %B%F{222}%~%f: '
      shuf -n 1 ~/temp.txt | figlet
    '';
  };

  # dotfiles. See github: https://github.com/spf5000/configs
  xdg.configFile."alacritty".source = ~/configs/.config/alacritty;
}
