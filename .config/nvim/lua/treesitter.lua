-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Setup parser install dir to the configs directory so that it is read-writable
  parser_install_dir = "~/configs/.config/nvim/treesitter_parsers",
  
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { 'go', 'lua', 'vim', 'query', 'rust' },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  -- NOTE: We're not installing the parsers through nvim-treesitter because they're installed via nix.
  auto_install = false,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,

  },
  indent = {
    enable = true,
  }
}
