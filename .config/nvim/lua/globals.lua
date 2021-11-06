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

-- AutoSave on exit
vim.cmd[[autocmd TextChanged,FocusLost,BufEnter * silent update]]
