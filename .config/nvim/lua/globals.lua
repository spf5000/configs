local indent = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = indent
vim.opt.tabstop = indent
vim.opt.softtabstop = indent
vim.opt.smartindent = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.colorcolumn = '120'

vim.o.termguicolors = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.errorbells = false
vim.g.mapleader = ' '

--netrw config
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 18

-- AutoSave on exit
-- vim.cmd[[autocmd TextChanged,FocusLost,BufEnter * silent update]]

-- theme
vim.cmd'syntax enable'
vim.o.termguicolors = true
vim.cmd'colorscheme dracula'
