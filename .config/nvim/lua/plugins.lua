local Plug = vim.fn['plug#']

-- vim plug through lua: https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
vim.call('plug#begin', '~/.config/nvim/plugged')
  Plug ('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})
  Plug 'preservim/nerdtree'

  -- Theme
  Plug 'gruvbox-community/gruvbox'
  Plug 'joshdick/onedark.vim'
  Plug 'shaunsingh/nord.nvim'
-- Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  -- LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'saadparwaiz1/cmp_luasnip'

vim.call('plug#end')

-- Load non-lua themes
-- vim.cmd[[colorscheme nord]]

-- Example config in lua
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false

-- Load the colorscheme
require('nord').set()
