local Plug = vim.fn['plug#']

-- vim plug through lua: https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug ('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})
  Plug 'preservim/nerdtree'

  -- Theme
  Plug 'gruvbox-community/gruvbox'

  -- Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  -- LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'L3MON4D3/LuaSnip'

vim.call('plug#end')

vim.cmd[[colorscheme gruvbox]]
