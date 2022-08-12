{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [
        {
          name = "dracula";
          src = pkgs.fetchFromGitHub {
              owner = "dracula";
              repo = "fish";
              rev = "610147cc384ff161fbabb9a9ebfd22b743f82b67";
              sha256 = "0pf65j87pgf2z3818lbijqnffam319x0gzll4v3hfiws04c08b2v";
          };
      }
    ];
    shellAliases = {
        system-update = "sudo nixos-rebuild switch --upgrade -I nixos-config=/home/sean/configs/nix/system/configuration.nix";
        home-update = "nix-channel --update && home-manager switch -f ~/configs/nix/home/sean/home.nix";
        tmux = "tmux a";
    };
    shellInit = ''
        fish_vi_key_bindings
        set -g fish_greeting

        function fish_prompt --description 'Informative prompt'
            #Save the return status of the previous command
            set -l last_pipestatus $pipestatus
            set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

            if functions -q fish_is_root_user; and fish_is_root_user
                printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                                 and set_color $fish_color_cwd_root
                                                                 or set_color $fish_color_cwd) \
                    (prompt_pwd) (set_color normal)
            else
                set -l status_color (set_color $fish_color_status)
                set -l statusb_color (set_color --bold $fish_color_status)
                set -l pipestatus_string (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

                printf '[%s] %s%s@%s %s%s %s%s%s \n> ' (date "+%H:%M:%S") (set_color brblue) \
                    $USER (prompt_hostname) (set_color $fish_color_cwd) $PWD $pipestatus_string \
                    (set_color normal)
            end
        end
    '';
  };
}
