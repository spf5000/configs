{ config, pkgs, ... }:

{
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
    # neovim
  ];

  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  programs.git = {
    enable = true;
    userName = "Sean Flinn";
    userEmail = "sflinn54@gmail.com";
  };

  programs.tmux = {
    enable = true;
    shortcut = "Space";
    newSession = true;
    shell = "/home/sean/.nix-profile/bin/zsh";
    terminal = "tmux-256color";
    extraConfig = ''
      # Colors for alacritty
      # set -ag terminal-overrides ",xterm-256color:RGB"

      # Vim setup
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -- -selection clipboard"
    '';
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    dotDir = ".config/zsh";
    shellAliases = {
      update = "sudo nixos-rebuild switch";
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
  # home.file.".tmux.conf".source = ~/configs/root/.tmux.conf;
}
