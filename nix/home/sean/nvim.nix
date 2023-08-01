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
        # theme
        dracula-vim

        # Telescope (fuzzy finder)
        plenary-nvim
        telescope-nvim

        # Treesitter (highlighting, function jumps, etc.)
	nvim-treesitter

        # LSP settup.
        nvim-lspconfig

	# LSP Code completion
        nvim-cmp
        cmp-nvim-lsp

	# Code snippets
        luasnip
        cmp_luasnip
        # cmp-buffer
	# vim-vsnip

	# neovim LSP
	neodev-nvim
      ];
  };
  # xdg.configFile."nvim/settings.lua".source = ~/configs/.config/nvim/init.lua;
  xdg.configFile."nvim/lua".source = ~/configs/.config/nvim/lua;
}
