{ config, pkgs, ... }:

{
  programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = ''
        :luafile ~/configs/.config/nvim/init.lua
      '';
      plugins = with pkgs.vimPlugins; [
        dracula-vim
        plenary-nvim
        telescope-nvim

        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-vsnip
        vim-vsnip
      ];
      # extraConfig = ''
      #   lua << EOF
      #     ${lib.strings.fileContents $HOME/configs/.config/nvim/temp.lua}
      #     EOF
      # '';
  };
  xdg.configFile."nvim/settings.lua".source = ~/configs/.config/nvim/init.lua;
  xdg.configFile."nvim/lua".source = ~/configs/.config/nvim/lua;
}
