local opt = vim.opt
local g = vim.g
-- ┌──────────────────┐
-- │ general settings │
-- └──────────────────┘
opt.undofile = true 
opt.undodir = "/home/nils/.cache"

-- ┌────────────────┐
-- │ tabs vs spaces │
-- └────────────────┘
opt.smartindent = true
opt.autoindent = true 
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true


-- ┌───────────────┐
-- │ fix clipboard │
-- └───────────────┘
opt.clipboard = "unnamedplus"

-- ┌─────────────┐
-- │ ui settings │
-- └─────────────┘
vim.o.relativenumber = true

-- ┌─────────────────┐
-- │ plugin settings │
-- └─────────────────┘
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "javascript", "html", "css", "python" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- ┌────────────────────────────────────────────────────────┐
-- │ extra lsp settings (TODO move to async file in future) │
-- └────────────────────────────────────────────────────────┘


-- new nvim-cmp shit
local cmp = require'cmp'
cmp.setup { confirmation = { completeopt = 'menu,menuone,noinsert' } }

cmp.setup({
snippet = {
  -- REQUIRED - you must specify a snippet engine
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  end,
},
window = {
  -- completion = cmp.config.window.bordered(),
  -- documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  ['<C-f>'] = cmp.mapping.scroll_docs(4),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' }, -- For vsnip users.
  -- { name = 'luasnip' }, -- For luasnip users.
  -- { name = 'ultisnips' }, -- For ultisnips users.
  -- { name = 'snippy' }, -- For snippy users.
}, {
  { name = 'buffer' },
})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['eslint'].setup {
    capabilities = capabilities
}

require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
}

require('lspconfig')['clangd'].setup {
    capabilities = capabilities
}

require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}


vim.api.nvim_set_keymap("n", "<Space>", ":NERDTreeToggle<CR>", { silent = true })
