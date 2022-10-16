local opts = { noremap = true  }
local telescope = require('telescope.builtin')

-- Telescope
vim.keymap.set('n', '<leader>ff', telescope.find_files, opts)
vim.keymap.set('n', '<leader>fg', telescope.live_grep, opts)
vim.keymap.set('n', '<leader>fb', telescope.buffers, opts)
vim.keymap.set('n', '<leader>fh', telescope.help_tags, opts)

-- File finder
vim.keymap.set('n', '<leader>nt', ':Vex<CR>', opts)
