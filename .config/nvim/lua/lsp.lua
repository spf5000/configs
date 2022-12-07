local nvim_lsp = require('lspconfig')
local cmp = require('cmp')

-- Hook LSP into completion
local my_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp
  .protocol
  .make_client_capabilities())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local my_on_attach = function()
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = 0 }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {buffer = 0})
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = 0})
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
    vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer = 0})
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer = 0})
    vim.keymap.set("n", "gf", vim.lsp.buf.formatting, {buffer = 0})
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, {buffer = 0})
    vim.keymap.set("n", "en", vim.diagnostic.goto_next, {buffer = 0})
    vim.keymap.set("n", "ep", vim.diagnostic.goto_prev, {buffer = 0})
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 
    'rust_analyzer', 
    'tsserver',
    'pylsp'
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = my_capabilities,
    completeUnimported = true,
    analyses = {unusedparams = true},
    staticcheck = true,
    on_attach = my_on_attach,
  }
end

-- LSP autocomplete
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- setting vim values

-- Setup nvim-cmp
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) 
        end
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        }),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        { name = 'vsnip' }, 
    }, {{name = 'buffer'}})
})

-- Enable inline errors
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
      {update_in_insert = true})
