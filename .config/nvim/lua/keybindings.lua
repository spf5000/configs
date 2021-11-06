local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true  }

-- Movement
keymap('n', '<c-j>', '<c-d>', opts)
keymap('n', '<c-k>', '<c-u>', opts)

-- Telescope
keymap('n', '<leader>fs', "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<cr>", opts)
keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)

-- File finder
keymap('n', '<leader>nt', ':NERDTree<CR>', opts)
