{ config, pkgs, ... }:

let
    inputs = import ~/configs/nix/inputs.nix;
in
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      system-update = "sudo nixos-rebuild switch --flake ${inputs.homeDir}/configs/nix/${inputs.system}#system --impure";
      home-update = "home-manager switch --flake ${inputs.homeDir}/configs/nix/${inputs.system}#home --impure";
      nix-update = "nix flake update ${inputs.homeDir}/configs/nix/${inputs.system}";
      ls = "lsd";
      cat = "bat -p";
      grep = "rg";
    };
    history = {
      ignoreDups = true;
      size = 1000;
      save = 1000;
      path = "$HOME/.config/zsh/history";
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
    ];
    initExtra = ''
      set -o vi
      PS1='%B%F{043}${inputs.shell} %fin %B%F{222}%~%f: '
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=0
      EDITOR=vim
    '';
  };
}
