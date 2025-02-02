local _ = require('plugins')
local _ = require('lsp')
local _ = require('options')
local _ = require('keymaps')
local _ = require('spell')
--local cmp = require('cmp')

vim.cmd("colorscheme jellybeans")
vim.cmd("colorscheme Tomorrow-Night-Bright")

-- Enable update_in_insert
vim.diagnostic.config({
    update_in_insert = true,
    signs = true,
})

vim.opt.backup = true
vim.opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }

vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.wildmode = "list:longest,full"
vim.o.wildmenu = true


--cmp.setup({
--    snippet = {
--        -- REQUIRED - you must specify a snippet engine
--        expand = function(args)
--            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--        end,
--    },
--    window = {
--        -- completion = cmp.config.window.bordered(),
--        -- documentation = cmp.config.window.bordered(),
--    },
--    mapping = cmp.mapping.preset.insert({
--        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--        ['<C-f>'] = cmp.mapping.scroll_docs(4),
--        ['<C-Space>'] = cmp.mapping.complete(),
--        ['<C-e>'] = cmp.mapping.abort(),
--        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--    }),
--    sources = cmp.config.sources({
--        { name = 'nvim_lsp' },
--    }, {
--        { name = 'buffer' },
--    })
--})
