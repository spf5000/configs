{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    shell = "~/.nix-profile/bin/zsh";
    terminal = "tmux-256color";
    extraConfig = ''
      # Colors for alacritty
      # set -ag terminal-overrides ",xterm-256color:RGB"

      # Vim setup
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      # X11
      # bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "xclip -in -selection clipboard"
      # Wayland
      bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel "wl-copy"
    '';
  };
}
