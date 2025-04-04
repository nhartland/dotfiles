return {
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        version = '*',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-path',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            cmp.setup {
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            lazydev = "[Lazy]",
                            vim_dadbod_completion = "[DB]",
                            nvim_lsp = "[LSP]",
                            buffer = "[buf]",
                            path = "[path]",
                            copilot = "[AI]",
                            nvim_lsp_signature_help = "[sig]",
                            obsidian = "[Obsidian]",
                            obsidian_new = "[Obsidian]",
                        })[entry.source.name]
                        -- Leave vim_item.kind untouched to display type
                        return vim_item
                    end
                },
                window = {
                    --completion = cmp.config.window.bordered(), -- rounded border
                    --documentation = cmp.config.window.bordered(),
                },
                experimental = {
                    ghost_text = true
                },
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },
                mapping = cmp.mapping.preset.insert {
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        local copilot = require 'copilot.suggestion'

                        if copilot.is_visible() then
                            copilot.accept()
                        elseif cmp.visible() then
                            cmp.confirm()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                performance = {
                    max_view_entries = 5
                },
                sources = {
                    {
                        name = 'lazydev',
                        group_index = 0,
                    },
                    { name = "vim-dadbod-completion",   group_index = 1 },
                    { name = 'nvim_lsp_signature_help', group_index = 1 },
                    { name = "copilot",                 group_index = 2 },
                    { name = 'nvim_lsp',                group_index = 2 },
                    { name = 'buffer',                  group_index = 3 },
                    { name = 'path',                    group_index = 3 },
                },
            }
        end,
    },
}
